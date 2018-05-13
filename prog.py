 

import MySQLdb

db = MySQLdb.connect("localhost","root","4451","group_project" )

query = db.cursor()

###Show stats for start time 
q = """select start_time from   `assigned_to`  procedure analyse ( ) """
query.execute(q)
for data in query:
	print "First packing was done at  - ",data[1]
	print "Last pacing was done at  - ",data[2]
	
###show stats for end time
q = """select end_time from   `assigned_to`  procedure analyse ( ) """
query.execute(q)
for data in query:
	print "First package was packed at   - ",data[1]
	print "Last package was packed at  - ",data[2]
	print "Average Packing time - ",data[7]

###show stats for package data
q = """select packeageDate from   `package`  procedure analyse ( )"""
query.execute(q)
for data in query:
	print "First package was packed on " , data[1]
	print "Last package was packed on " , data[2]
	print "Average inverval for packign packages is  ", data[7]," days"

###show stats for weight
q = """select weight from   `package`  procedure analyse ( )"""
query.execute(q)
for data in query:
	print "Max weight of a package is  " , data[1]
	print "Least weight of a package is " , data[2]
	print "Average weight of the package is  ", data[7]

###list all the organizatio alons with list
q = """select concat(name,", ",address) as Organization from united_helper"""

query.execute(q)
print "List of Organization : "
for data in query.fetchall():
	for i in data:
		print " ",i

###for volunteer and corresponding package
q = """select volunteer.name as vname, packing_list.name as pname from
	assigned_to join volunteer on 
	volunteer.volunteerId = assigned_to.volunteerId  join task on 
	task.code  = assigned_to.code join packing_task on 
	task.code  = packing_task.code join packing_list on 
	packing_list.listId = packing_task.listId"""
query.execute(q)
print "Volunteer Handling which package : "
for data in query.fetchall():
	print " ",data[0]," - ",data[1]
q = """select package.packageId,item.name from package join contains on
	package.packageId = contains.packageId join item on 
	contains.itemId = item.itemId"""
query.execute(q)
print " which Package contains which items: "
for data in query.fetchall():
	print " ",data[0]," - ",data[1]

###packge with corresponsind task
q = """ select item.name , packing_task.totalPackages from package 
	join contains on package.packageId = contains.packageId 
	join item on  contains.itemId = item.itemId 
	join packing_task on package.code = packing_task.ptask_code"""
query.execute(q)
print " Count of packages in each packing task: "
for data in query.fetchall():
	print " ",data[0]," - ",data[1]

###addition of package alon with error handling
print """Creating new package : """
insert_packingid = raw_input("Enter package id :")
insert_listid  = raw_input("Enter packing list id : ");
insert_taskcode  = raw_input("Enter packing task code :");
insert_weight  = raw_input("Enter weight of the package : ");
insert_packing_date  = raw_input("Enter the date of packaging : ");
q = "insert into package values ("+insert_packingid+","+insert_weight+",'"+insert_packing_date+"',"+insert_taskcode+","+insert_listid+")"
try:
	query.execute(q)
	print "Update a Package Sucessfully !"
except MySQLdb.Error, e:
	print "error incorrect package,list id or task code"


###deleting package incuidng error handling
delete_pid = raw_input("Enter the package id to delete :")
q = "delete from package where packageId = " + delete_pid 
p = "delete from contains where packageId = "+delete_pid
query.execute(q)
try:
	query.execute(p)
except MySQLdb.Error, e:
	print "package id not exists"

###updating Volunteer details
vid = raw_input("Enter the Volunteer id to change : ")
vname = raw_input("Enter the volunteer name : ")
vaddress = raw_input("Enter volunteer address : ")
vphone = raw_input("Enter the phone number : ")
q = "update volunteer set name = '"+vname+"',address = '"+vaddress+"', phoneNo = '"+vphone+"' where volunteerId = " +vid

try:
	query.execute(q)
	print " Sucessfully updated !"
except MySQLdb.Error, e:
	print "Invalid Volunteer Id"


### Addition of new organization
oid = raw_input("Enter Organization id :") 
oname = raw_input("Enter new organization Name : ")
oaddress = raw_input("Enter  address : ") 
ophone = raw_input("Enter phone : ")

q = "insert into united_helper values ("+oid+",'"+oname+"','"+oaddress+"','"+ophone+"')";
query.execute(q)
print "updated "

db.close()
