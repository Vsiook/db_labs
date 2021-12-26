import csv
import psycopg2

username = 'vasiastafaniuk'
password = 'admin'
database = 'vasiastefaniuk_DB'
host = 'localhost'
port = '5432'

con = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
print(type(con))

INPUT_CSV_FILE = 'cars.csv'

query_0 = '''
DELETE FROM price CASCADE;
DELETE FROM models CASCADE;
DELETE FROM cars CASCADE;
'''

query_1 = '''
INSERT INTO cars (c_id,c_name) VALUES (%s, %s)
'''
query_2 = '''
INSERT INTO models (c_id,model_name,transmission) VALUES (%s,%s, %s)
'''
query_3 = '''
INSERT INTO price (model_name,price) VALUES (%s, %s)
'''

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
print(type(conn))

with conn:
    cur = conn.cursor()
    cur.execute(query_0)

    #first table
    cars = []
    temp = 0
    t1 = {}
    with open(INPUT_CSV_FILE, 'r') as inf:
        reader = csv.DictReader(inf)
        for idx, row in enumerate(reader):
            if row['manufacturer_name'] in cars:
                continue
            else:
                temp += 1
                cars.append(row['manufacturer_name'])
                t1[row['manufacturer_name']] = temp
                values = (temp, row['manufacturer_name'])
                cur.execute(query_1, values)

    #second table
    models = []
    temp = 0
    with open(INPUT_CSV_FILE, 'r') as inf:
        reader = csv.DictReader(inf)
        for idx, row in enumerate(reader):
            if row['model_name'] in models:
                continue
            else:
                temp = t1[row['manufacturer_name']]
                models.append(row['model_name'])
                values = (temp, row['model_name'], row['transmission'])
                cur.execute(query_2, values)

    #third table
    models = []
    with open(INPUT_CSV_FILE, 'r') as inf:
        reader = csv.DictReader(inf)
        for idx, row in enumerate(reader):
            if row['model_name'] in models:
                continue
            else:
                print(idx)
                models.append(row['model_name'])
                values = (row['model_name'], int(float(row['price_usd'])))
                cur.execute(query_3, values)

    conn.commit()