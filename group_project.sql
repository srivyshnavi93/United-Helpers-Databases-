


#to see if there are any existing tables 
show tables;

#drop table which we are using and if there are any 
drop table if exists contained_items;
drop table if exists given_task;
drop table if exists packages;
drop table if exists task;
drop table if exists type;
drop table if exists items;
drop table if exists packing_list;
drop table if exists volunteers;

#to see if there are any existing tables 
show tables;

#volunteer table with following attributes
create table volunteers(
	volunteer_id int not null,
	volunteer_name varchar(256),
	volunteer_address varchar(512),
	volunteer_phone bigint(20),
	primary key(volunteer_id)
);

#packing list  table with following attributes 
create table packing_list(
	packing_list_id int not null,
	packing_list_name varchar(256),
	packing_list_description varchar(512),
	primary key (packing_list_id)
);

# items table with following attributes 
create table items(
	item_id int not null,
	item_desription varchar(512),
	item_value float,
	item_quantity int,
	primary key (item_id)
);

# types table with following attributes 
create table type(
	task_type varchar(256) not null,
	primary key (task_type)
);

#task  table with following attributes 
create table task(
	task_code int not null,
	task_description varchar(512),
	task_type varchar(256),
	status varchar(256),
	packing_list_id int,
	primary key(task_code),
	foreign key (task_type) references type (task_type),
	foreign key (packing_list_id) references packing_list (packing_list_id)
);
# packages table with following attributes 
create table packages(
	package_id int not null,
	package_created_date date,
	package_total_weight float,
	task_code int,
	primary key (package_id),
	foreign key (task_code) references task (task_code)
);

#  given task table with following attributes 
create table given_task(
	volunteer_id int not null,
	task_code int not null,
	start_time time,
	end_time time,
	primary key(volunteer_id,task_code),
	foreign key (volunteer_id) references volunteers (volunteer_id),
	foreign key (task_code) references task (task_code)
);

# contained items table with following attributes 
create table contained_items(
	package_id int not null,
	item_id int not null,
	primary key (package_id,item_id),
	foreign key (package_id) references packages (package_id),
	foreign key (item_id) references items (item_id)
);

#to check weather tables are created or not ! 
show tables;

/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into volunteers (volunteer_id,volunteer_name,volunteer_address,volunteer_phone) values 
(1,'Jim','1012 Regent Drive,Dekalb,Chicago,IL',8272827317),
(2,'Jack','1062 Regent Drive,Dekalb,Chicago,IL',8273827317),
(3,'Jill','1085 castle drive,Dekalb,Chicago,IL',8283827317),
(4,'Goth','105 castle drive,Dekalb,Chicago,IL',8280027317),
(5,'Gayatri','120 Wisconcin regent,Iowa,Minnesota',8280117317),
(6,'Goku','121 Dunwoody,Atalnta,GA',8280777317),
(7,'Daffy','12 Dunwoody,Atalnta,GA',8273756317),
(8,'Adi','2 Fotis,Dekalb,IL',8200000317),
(9,'vyshnavi','90 Fotis,newyork,NY',8277778971),
(10,'tony','110 nunthan,newjersey,NJ',8211111317);

/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into packing_list (packing_list_id  ,packing_list_name  , packing_list_description ) values 
(101,'food','fdgbdh'),
(102,'child-care','fdhfhdj'),
(103,'medicals','fdhfj'),
(104,'stationary','dfhfj'),
(105,'first-aid','hj'),
(106,'sanitizers','yuk'),
(107,'cosmetics','fghfyj'),
(108,'electronics','dhgjtk'),
(109,'clothing','hggj'),
(110,'utensils','gfjfk');

/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into type (task_type) values ('recurring'),('grouping'),('assigning'),('finance'),('accounting'),('campaigning'),('ordering'),('revising');
/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into task( task_code ,task_description,task_type,  status , packing_list_id ) values 
(1001,'blahblah','recurring','ongoing',101),
(1002,'blahblah','recurring','ongoing',101),
(1003,'blahblah','grouping','open',101),
(1004,'blahblah','finance','open',105),
(1005,'blahblah','recurring','delivered',106),
(1006,'blahblah','grouping','delivered',108),
(1007,'blahblah','accounting','delivered',103),
(1008,'blahblah','accounting','delivered',105),
(1009,'blahblah','grouping','open',107),
(1010,'blahblah','accounting','delivered',108);

/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into given_task (volunteer_id,task_code,start_time,end_time) values
(1,1001,'09:00:00','10:00:00'),
(10,1001,'09:00:00','10:00:00'),
(2,1003,'08:00:00','10:00:00'),
(3,1002,'07:00:00','10:00:00'),
(4,1004,'05:00:00','08:00:00'),
(5,1001,'05:00:00','09:00:00'),
(6,1005,'06:00:00','10:00:00'),
(7,1006,'07:00:00','01:00:00'),
(8,1007,'10:00:00','11:00:00'),
(9,1008,'09:00:00','10:00:00');
/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into items (item_id,item_desription, item_value, item_quantity) values
(201,'blahblah',6000,50),
(202,'blahblah',8900,50),
(203,'blahblah',9800,58),
(204,'blahblah',7800,40),
(205,'blahblah',6500,89),
(206,'blahblah',9800,56),
(207,'blahblah',4500,10),
(208,'blahblah',3400,456),
(209,'blahblah',0900,123),
(210,'blahblah',1200,500);

/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into packages(package_id,package_created_date,package_total_weight,task_code) values
(301,'2016-11-01',25,1007),
(302,'2001-09-09',95,1006),
(303,'2002-06-08',85,1005),
(304,'2004-02-06',35,1004),
(305,'2007-05-06',55,1003),
(306,'2003-10-04',26,1002),
(307,'2002-11-04',29,1003),
(308,'2008-10-01',60,1002),
(309,'2001-11-01',94,1001),
(310,'2004-01-01',105,1001);
 
/*  
	Creating entries into the Tables depending on the coloumns and type of data
*/

insert into contained_items (package_id,item_id) values
(301,210),
(302,209),
(303,208),
(304,207),
(305,206),
(306,205),
(307,204),
(308,203),
(309,202),
(310,201);

/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from contained_items;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from given_task;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from packages;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from task;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from type;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from items;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from packing_list;
/* Print values in tables just to ensure 
data is entered into the table 
*/
select * from volunteers;
