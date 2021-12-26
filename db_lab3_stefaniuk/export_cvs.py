import csv
import psycopg2

username = 'vasiastafaniuk'
password = 'admin'
database = 'vasiastefaniuk_DB'
host = 'localhost'
port = '5432'

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)

csv_out = 'carsOUT.csv'

with conn:
    cur = conn.cursor()
    cur.execute('''
       select * from cars 
        left join models on cars.c_id = models.c_id
        left join price on models.model_name = price.model_name
    ''')
    fields = [x[0] for x in cur.description]
    with open(csv_out, 'w') as outfile:
        csv.writer(outfile).writerow(fields)
        for row in cur:
            csv.writer(outfile).writerow([str(x) for x in row])