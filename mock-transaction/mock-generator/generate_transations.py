import irisnative
import requests
import random
import argparse
import sys
import time
import datetime

# db config
DB_HOST = "datalake"
DB_PORT = 1972
DB_NAMESPACE = "APP"
DB_USER = "_system"
DB_PASS = "sys"

# api config
URL = "http://bankingtrnsrv:52773/csp/appint/rest/transaction/"
HEADERS = {
    "accept": "application/json",
    "Content-Type": "application/json"
}

TRANS_TYPES = ["PAYMENT"]  # add more types if needed

def fetch_accounts():
    conn = irisnative.createConnection(DB_HOST, DB_PORT, DB_NAMESPACE, DB_USER, DB_PASS)
    cursor = conn.cursor()
    cursor.execute("SELECT BC_ACC_NUMBER FROM IRISDEMO.BC_MERCH_ACCOUNT")
    merch_accounts = [row[0] for row in cursor.fetchall()]
    cursor.execute("SELECT BC_ACC_NUMBER FROM IRISDEMO.BC_ACCOUNT")
    accounts = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return accounts, merch_accounts

def fetch_stats():
    conn = irisnative.createConnection(DB_HOST, DB_PORT, DB_NAMESPACE, DB_USER, DB_PASS)
    cursor = conn.cursor()
    cursor.execute("SELECT count(*) FROM IRISDemo.BC_TRANSACTIONS")
    number_of_transactions = cursor.fetchone()[0]
    cursor.execute("SELECT count(*) FROM IRISDEMO.CS_FRAUD_COMPLAINT")
    number_of_frauds_compliant = cursor.fetchone()[0]
    cursor.execute("SELECT count(*), BC_TRANS_IS_FRAUD FROM IRISDemo.BC_TRANSACTIONS group by BC_TRANS_IS_FRAUD")
    fraud_type_counts = cursor.fetchall()
    cursor.execute("SELECT count(*), BC_TRANS_WAS_BLOCKED FROM IRISDemo.BC_TRANSACTIONS group by BC_TRANS_WAS_BLOCKED")
    blocked_type_counts = cursor.fetchall()
    cursor.close()
    conn.close()
    return number_of_transactions, number_of_frauds_compliant, fraud_type_counts, blocked_type_counts

def random_transaction(accounts, merch_accounts):
    trans_type = random.choice(TRANS_TYPES)
    amount = random.randint(5000, 5002)
    from_account = random.choice(accounts)
    to_account = random.choice(merch_accounts)
    return {
        "TransType": trans_type,
        "Amount": str(amount),
        "FromAccountNumber": from_account,
        "ToAccountNumber": to_account
    }

def send_transaction(data):
    try:
        response = requests.post(URL, headers=HEADERS, json=data, timeout=5)
        return response.status_code, response.text, data, response
    except Exception as e:
        return None, str(e), data, None

def print_stats(number_of_transactions, number_of_frauds_compliant, fraud_type_counts, blocked_type_counts, logf=None):
    lines = []
    lines.append("\n====== IRIS DATA PLATFORM TRANSACTION STATS ======")
    lines.append(f"Total transactions:       {number_of_transactions}")
    lines.append(f"Fraud complaints:         {number_of_frauds_compliant}")
    lines.append("\nTransaction counts by type:")
    for count, fraud_type in fraud_type_counts:
        fraud_type_str = str(fraud_type) if fraud_type is not None else "NULL"
        lines.append(f"  Fraud type {fraud_type_str:8}: {count}")
    lines.append("\nTransaction counts by blocked:")
    for count, blocked_type in blocked_type_counts:
        blocked_type_str = str(blocked_type) if blocked_type is not None else "NULL"
        lines.append(f"  Blocked   {blocked_type_str:8}: {count}")
    lines.append("=================================================\n")
    out = "\n".join(lines)
    print(out)
    if logf:
        logf.write(out + "\n")

def add_million_to_balances():
    db_host = "bankingcore"
    conn = irisnative.createConnection(db_host, DB_PORT, DB_NAMESPACE, DB_USER, DB_PASS)
    cursor = conn.cursor()
    for table in ["IRISDemo.Account", "IRISDemo.CustomerAccount"]:
        cursor.execute(f"UPDATE {table} SET Balance = Balance + 1000000")
    conn.commit()
    cursor.close()
    conn.close()
    print("Added 1000000 to all Balance fields in Account and CustomerAccount.")

def main():
    parser = argparse.ArgumentParser(description="Send random banking transactions")
    parser.add_argument("--num", type=int, required=True, help="Number of random POST calls to execute")
    parser.add_argument("--add-balance", action='store_true', help="Add 1,000,000 to Balance fields in Account tables")
    args = parser.parse_args()

    if args.add_balance:
        add_million_to_balances()
        return

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    logfilename = f"transaction_{timestamp}.log"

    accounts, merch_accounts = fetch_accounts()

    with open(logfilename, "w") as logf:
        for idx in range(args.num):
            data = random_transaction(accounts, merch_accounts)
            status, body, tx_data, response = send_transaction(data)
            sys.stdout.write("\r" + " " * 120 + "\r")
            if status:
                resp_code = response.status_code if response is not None else "NA"
                last_status = f"#{idx+1:02d} | Status: {status} | RespCode: {resp_code} | Amount: {tx_data['Amount']} | From: {tx_data['FromAccountNumber']} -> To: {tx_data['ToAccountNumber']} | Type: {tx_data['TransType']}"
            else:
                last_status = f"#{idx+1:02d} | FAILED | {body}"
            sys.stdout.write(last_status)
            sys.stdout.flush()
            logf.write(last_status+"\n")
            time.sleep(0.1)
        print()
        stats = fetch_stats()
        print_stats(*stats, logf=logf)
        logf.flush()

if __name__ == "__main__":
    main()




# /appint/rest
# http://sojen0:9092/csp/sys/sec/%25CSP.UI.Portal.Applications.Web.zen?PID=%2Fcsp%2Fappint%2Frest#0
# unthauthenticated + app role
# Example usage:
# python3 generate_transations.py --num 10

#python3 generate_transations.py --add-balance --num 2