import matplotlib.pyplot as plt
import psycopg2

username = 'vasiastafaniuk'
password = 'admin'
database = 'vasiastefaniuk_DB'
host = 'localhost'
port = '5432'

con = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)
print(type(con))

query_1_1 = '''
select count(transmission) from models where transmission = 'automatic'
'''
query_1_2 = '''
select count(transmission) from models where transmission = 'mechanical'
'''

query_2 = '''
CREATE VIEW COUNT_MODEL AS
select c_name, count(model_name)
	from cars
	left join models on cars.c_id = models.c_id
	group by c_name
'''

query_3 = '''
CREATE VIEW AVERAGE_PRICE_COMPANY_MODELS  AS
select c_name, (sum(price)/count(models.model_name))
	from cars
		join models on cars.c_id = models.c_id
		join price on models.model_name = price.model_name
group by c_name
'''

with con:
    cur = con.cursor()

    print('1.  ')
    title = ["automatic", "mechanical"]
    info = []
    cur.execute(query_1_1)
    for row in cur:
        info.append(row[0])
    cur.execute(query_1_2)
    for row in cur:
        info.append(row[0])

    figure, (bar_ax, pie_ax, bar_2_ax) = plt.subplots(1, 3, figsize=(22,12))
    pie_ax.pie(info, labels=title, autopct='%1.1f%%')
    pie_ax.set_title('Розподілення видів коробок передач')

    print("\n2. ")
    cur.execute('select * from COUNT_MODEL')
    companyName = []
    counter = []
    for row in cur:
        print(row)
        companyName.append(row[0])
        counter.append(row[1])

    bar_ax.bar(companyName, counter, width=0.5)
    bar_ax.set_xticklabels(companyName, rotation=35, ha='right')
    bar_ax.set_title('кількість моделей в кожного атовиробника')
    bar_ax.set_ylabel("кількість")
    bar_ax.set_xlabel("company name")

    print("\n3. ")
    cur.execute('select * from AVERAGE_PRICE_COMPANY_MODELS')

    companyName = []
    counter = []
    for row in cur:
        print(row)
        companyName.append(row[0])
        counter.append(row[1])

    bar_2_ax.bar(companyName, counter, width=0.5)
    bar_2_ax.set_xlabel('company name')
    bar_2_ax.set_ylabel("middle price")

    plt.show()
