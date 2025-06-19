import irisnative
import requests
import random
import argparse
import sys
import time
import datetime

# db config
db_host = "datalake"
db_port = 1972
db_ns = "APP"
db_user = "_system"
db_pass = "sys"

# api config
URL = "http://bankingtrnsrv:52773/csp/appint/rest/transaction/"
HEADERS = {"accept": "application/json", "Content-Type": "application/json"}

TRANS_TYPES = ["PAYMENT"]

# fetch accounts

def fetch_accounts():
    conn = irisnative.createConnection(db_host, db_port, db_ns, db_user, db_pass)
    cur = conn.cursor()
    cur.execute("SELECT BC_ACC_NUMBER FROM IRISDEMO.BC_MERCH_ACCOUNT")
    merch = [r[0] for r in cur.fetchall()]
    cur.execute("SELECT BC_ACC_NUMBER FROM IRISDEMO.BC_ACCOUNT")
    acc = [r[0] for r in cur.fetchall()]
    cur.close()
    conn.close()
    return acc, merch

# update city for fraud
def update_city():
    conn = irisnative.createConnection(db_host, db_port, db_ns, db_user, db_pass)
    cur = conn.cursor()
    cur.execute("""
        UPDATE IRISDemo.BC_TRANSACTIONS
        SET CITY = CASE
            WHEN FLOOR(MOD(ID,95)+1) < 10
                THEN 'FR-0' || CAST(FLOOR(MOD(ID,95)+1) AS VARCHAR(2))
            ELSE 'FR-' || CAST(FLOOR(MOD(ID,95)+1) AS VARCHAR(2))
        END
        WHERE BC_TRANS_IS_FRAUD = 1
          AND CITY IS NULL
    """)
    conn.commit()
    cur.close()
    conn.close()

# send one random transaction

def random_transaction(accounts, merch, min_amt=5000, max_amt=5002):
    t = random.choice(TRANS_TYPES)
    amt = str(random.randint(min_amt, max_amt))
    f = random.choice(accounts)
    t_acc = random.choice(merch)
    return {"TransType": t, "Amount": amt,
            "FromAccountNumber": f, "ToAccountNumber": t_acc}

# post and return status

def send_transaction(data):
    try:
        r = requests.post(URL, headers=HEADERS, json=data, timeout=5)
        return r.status_code, r.text, data, r
    except Exception as e:
        return None, str(e), data, None

# fetch stats
def fetch_stats():
    conn = irisnative.createConnection(db_host, db_port, db_ns, db_user, db_pass)
    cur = conn.cursor()
    cur.execute("SELECT count(*) FROM IRISDemo.BC_TRANSACTIONS")
    tx_cnt = cur.fetchone()[0]
    cur.execute("SELECT count(*) FROM IRISDEMO.CS_FRAUD_COMPLAINT")
    fraud_cnt = cur.fetchone()[0]
    cur.execute("SELECT count(*), BC_TRANS_IS_FRAUD FROM IRISDemo.BC_TRANSACTIONS GROUP BY BC_TRANS_IS_FRAUD")
    fraud_types = cur.fetchall()
    cur.execute("SELECT count(*), BC_TRANS_WAS_BLOCKED FROM IRISDemo.BC_TRANSACTIONS GROUP BY BC_TRANS_WAS_BLOCKED")
    blocked = cur.fetchall()
    cur.close()
    conn.close()
    return tx_cnt, fraud_cnt, fraud_types, blocked

# print stats
def print_stats(tx_cnt, fraud_cnt, fraud_types, blocked, logf=None):
    lines = ["\n====== IRIS DATA PLATFORM TRANSACTION STATS ======",
             f"Total transactions:       {tx_cnt}",
             f"Fraud complaints:         {fraud_cnt}",
             "\nTransaction counts by fraud:"]
    for cnt, ft in fraud_types:
        ft_str = str(ft) if ft is not None else "NULL"
        lines.append(f"  Fraud {ft_str:8}: {cnt}")
    lines.append("\nTransaction counts by blocked:")
    for cnt, bt in blocked:
        bt_str = str(bt) if bt is not None else "NULL"
        lines.append(f"  Blocked {bt_str:8}: {cnt}")
    lines.append("=================================================\n")
    out = "\n".join(lines)
    print(out)
    if logf:
        logf.write(out + "\n")

# main

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--num", type=int)
    p.add_argument("--increase-balances", action="store_true")
    p.add_argument("--min-amount", type=int)
    p.add_argument("--max-amount", type=int)
    p.add_argument("--delete", action="store_true")
    args = p.parse_args()

    if args.increase_balances:
        add_million_to_balances()
        return
    if args.delete:
        delete_all_rows()
        return
    if not args.num:
        print("Provide --num or --increase-balances or --delete.")
        return

    min_amt = args.min_amount or 5000
    max_amt = args.max_amount or 5002
    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    logfn = f"transaction_{ts}.log"

    acc, merch = fetch_accounts()
    with open(logfn, "w") as logf:
        for i in range(args.num):
            data = random_transaction(acc, merch, min_amt, max_amt)
            status, body, tx, resp = send_transaction(data)
            sys.stdout.write("\r" + " "*120 + "\r")
            if status:
                code = resp.status_code if resp else "NA"
                last = (f"#{i+1:02d} | Status: {status} | RespCode: {code} | "
                        f"Amt: {tx['Amount']} | From: {tx['FromAccountNumber']} -> {tx['ToAccountNumber']} | "
                        f"Type: {tx['TransType']}")
            else:
                last = f"#{i+1:02d} | FAILED | {body}"
            sys.stdout.write(last); sys.stdout.flush()
            logf.write(last + "\n")

            # update city for fraud
            update_city()

            time.sleep(0.3)
        print()
        stats = fetch_stats()
        print_stats(*stats, logf)

if __name__ == "__main__":
    main()



# /appint/rest
# http://sojen0:9092/csp/sys/sec/%25CSP.UI.Portal.Applications.Web.zen?PID=%2Fcsp%2Fappint%2Frest#0
# unthauthenticated + app role + recompile production + restartd prodction
# Example usage:
# python3 generate_transations.py --num 10

#   
#   python3 generate_transations.py --delete
#   python3 generate_transations.py --increase-balances

#   python3 generate_transations.py  --min-amount 20 --max-amount 300 --num 10


# todo: 2018 --> 2025
# todo: add blocked to fraud for the 500k