import irisnative
import requests
import random
import argparse
import json

# 1. open a connection
conn = irisnative.createConnection("datalake", 1972, "APP", "_system", "sys")
db = irisnative.createIris(conn)
cursor = conn.cursor()
# 2. run first query into a list
cursor.execute("SELECT BC_ACC_NUMBER FROM IRISDEMO.BC_MERCH_ACCOUNT")
merch_accounts = [row[0] for row in cursor.fetchall()]

# 3. run second query into a list
cursor.execute("SELECT BC_ACC_NUMBER FROM IRISDEMO.BC_ACCOUNT")
accounts = [row[0] for row in cursor.fetchall()]

# 4. clean up
cursor.close()
conn.close()

# 5. use or inspect your lists
#print("Merch accounts:", merch_accounts)
#print("Accounts:", accounts)
URL = "http://bankingtrnsrv:52773/csp/appint/rest/transaction/"
HEADERS = {
    "accept": "application/json",
    "Content-Type": "application/json"
}

TRANS_TYPES = ["PAYMENT"] #, "TRANSFER", "WITHDRAWAL"]

def random_transaction():
    trans_type = random.choice(TRANS_TYPES)
    amount = random.randint(1, 9990000)
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
        #print(f"Status: {response.status_code} | Body: {response.text} \n\n")
        print(f"amount: {data['Amount']} | from: {data['FromAccountNumber']} | to: {data['ToAccountNumber']} | type: {data['TransType']}")
    except Exception as e:
        print(f"Request failed: {e} \n\n")

def main():
    parser = argparse.ArgumentParser(description="Send random banking transactions")
    parser.add_argument("--num", type=int, required=True, help="Number of random POST calls to execute")
    args = parser.parse_args()

    for _ in range(args.num):
        data = random_transaction()
        send_transaction(data)

if __name__ == "__main__":
    main()

# python3 generate_transations.py --num 10