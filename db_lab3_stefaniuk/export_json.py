import json
import psycopg2

username = 'vasiastafaniuk'
password = 'admin'
database = 'vasiastefaniuk_DB'
host = 'localhost'
port = '5432'

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)

query = '''
select * from cars 
 left join models on cars.c_id = models.c_id
 left join price on models.model_name = price.model_name
'''

data = {}
with conn:
    cur = conn.cursor()
    cur.execute(query)
    rows = []
    fields = [x[0] for x in cur.description]
    for row in cur:
      rows.append(dict(zip(fields, row)))
    data = rows

with open('carsOUT.json', 'w') as json_out:
  json.dump(data, json_out, default=str)