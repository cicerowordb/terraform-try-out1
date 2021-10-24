#!/bin/bash
apt update
apt install -y coreutils
apt install -y python-pip
pip install flask mysql-connector-python mysql-connector-python-rf
apt install -y awscli nginx curl &
echo '<h1>Terraform Rules!!!</h1>' | tee /var/www/html/index1.html
echo '*  *    * * *   root    for file in $(aws s3 ls s3://bucket-s3-with-html-files-to-deploy/|tr -s " " ";"|cut -d ";" -f 4); do aws s3 cp s3://bucket-s3-with-html-files-to-deploy/$file /var/www/html/; done' | tee -a /etc/crontab
echo '#' | tee -a /etc/crontab
echo -n "---DATABASE---" | tee /etc/data-base.cfg
IFS='' read -r -d '' createdatabase <<"EOF"
#!/usr/bin/python2
#pip install flask mysql-connector-python mysql-connector-python-rf
import mysql.connector
from mysql.connector import errorcode
with open("/etc/data-base.cfg") as f:
    address = f.readlines()
address = str(address[0])
db_connection = mysql.connector.connect(host=address, user="databaseadmin", password="123qweasdzxc123qweasdzxc")
db_cursor = db_connection.cursor()
db_cursor.execute("CREATE DATABASE ancientgods")
db_connection.close()
db_connection = mysql.connector.connect(host=address, user="databaseadmin", password="123qweasdzxc123qweasdzxc", database="ancientgods")
db_cursor = db_connection.cursor()
db_cursor.execute("""CREATE TABLE AncientGods (
                       id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                       romanname VARCHAR(30) NOT NULL,
                       greekname VARCHAR(30) NOT NULL,
                       title VARCHAR(30),
                       sonof VARCHAR(30),
                       power VARCHAR(30),
                       regiterdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) """)
db_connection.close() 
EOF
echo "$createdatabase" | tee /home/admin/create-database.py
IFS='' read -r -d '' app <<"EOF"
#!/usr/bin/python2
#pip install flask mysql-connector-python mysql-connector-python-rf

from flask import Flask, request
import mysql.connector
from mysql.connector import errorcode

with open("/etc/data-base.cfg") as f:
    address = f.readlines()
address = str(address[0])

app = Flask(__name__)

@app.route("/")
def initial_message():
    message="""<h1>Ancient Gods</h1>
To use this script try:
<ul>
<li>Insert a new item:
  <ul>
    <li><b>/insert_database?romanname=Jupiter&greekname=Zeus&title=King+of+Gods&sonof=Chronos&power=flash</b>
    <li><b>/insert_database?romanname=Juno&greekname=Hera&title=Queen+of+Gods&sonof=Chronos&power=motherhood</b>
    <li><b>/insert_database?romanname=Minerva&greekname=Atena&title=Goddess+of+Wisdow&sonof=Jupiter&power=war+strateg+and+wisdow</b>
    <li><b>/insert_database?romanname=Mars&greekname=Ares&title=God+of+War&sonof=Jupiter&power=strenght</b>
  </ul>
<li>List table content:  
  <ul><li><b>/list_database</b></ul>
</ul>
"""
    return message, 200

@app.route("/insert_database")
def insert_database():
    if "romanname" in request.args and "greekname" in request.args:
        romanname = request.args.get("romanname")
        greekname = request.args.get("greekname")
        title = request.args.get("title")
        sonof = request.args.get("sonof")
        power = request.args.get("power")
        db_connection = mysql.connector.connect(host=address, user="databaseadmin", password="123qweasdzxc123qweasdzxc", database="ancientgods")
        db_cursor = db_connection.cursor()
        sql = "INSERT INTO AncientGods (romanname, greekname, title, sonof, power) VALUES ('"+romanname+"', '"+greekname+"', '"+title+"', '"+sonof+"', '"+power+"')"
        db_cursor.execute(sql)
        db_connection.commit()
        db_cursor.close()
        db_connection.close()
        return "<h1>Inserted</h1>",200
    else:
        print("Some info is not present in the request")
        return "<h1>ERROR:</h1> Some info is not present in the request",400

@app.route("/list_database/")
def list_database():
    db_connection = mysql.connector.connect(host=address, user='databaseadmin', password='123qweasdzxc123qweasdzxc', database='ancientgods')
    db_cursor = db_connection.cursor()
    db_cursor.execute("SELECT * FROM AncientGods")
    result = db_cursor.fetchall()
    db_connection.close()
    print("Displaying table content")
    response =  "<h1>Table's Content</h1><hr>"
    response += "<table border=1 cellspading=0 cellspacing=0>"
    response += "<tr><th>ID</td><th>Roman Name</th><th>Greek Name</th><th>Title</th><th>Son of</th><th>Power</th><th>Time Stamp</th></tr>"
    for item in result:
        response += "<tr><td>"+str(item[0])+"</td><td>"+str(item[1])+"</td><td>"+str(item[2])+"</td><td>"+str(item[3])+"</td><td>"+str(item[4])+"</td><td>"+str(item[5])+"</td><td>"+str(item[6])+"</td></tr>"
    response += "</table>"
    return response,200

app.run(host='0.0.0.0', port=5000, debug=False)
EOF
echo "$app" | tee /home/admin/app.py
/usr/bin/python2 /home/admin/create-database.py
/usr/bin/python2 /home/admin/app.py