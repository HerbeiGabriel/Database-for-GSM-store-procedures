create database GsmLab3;

use GsmLab3;

create table version_
(
ver int default 0,
sct int 
);
insert into version_ values
(0, 1);
create table Brand
(
Name_Brand varchar(30) UNIQUE,
Profit float UNIQUE,
PRIMARY KEY(Name_Brand),
);

create table Employees
(
Employee_ID int NOT NULL,
Salary int NOT NULL,
Namee varchar(20),
Surname varchar(20),
PRIMARY KEY (Employee_ID),
);
create table Phones
(
Price int NOT NULL,
Description varchar(20) NOT NULL,
CPU varchar(20) UNIQUE,
RAM varchar(20),
PRIMARY KEY (Description),
);
create table Shifts
(
Time_open int NOT NULL,
Time_close int NOT NULL,
Time_date date Not NULL,
Employee_ID int REFERENCES Employees(Employee_ID),
)
create table Profit
(
Time_date date NOT NULL,
Nr_Phones_Sold int,
Salary int,
);
create table most_sold_phones
(
Description varchar(20) REFERENCES Phones(Description),
Profit int UNIQUE,
);
create table Computers
(
Model varchar(20),
Price int,
Date_model Date,
);

create procedure v1 as
begin
alter table Employees
add year_experience int
print 'The database was upgraded from version 0 to 1'
end

create procedure v1_ as
begin
alter table Employees
drop column year_experience
print 'The database was downgraded from version 1 to 0'
end
go


create procedure v2 as
begin
alter table Employees
add constraint S_2 default 2000
for Salary
print 'The database was upgraded from version 1 to 2'
end 
go

create procedure v2_ as
begin
alter table Employees
drop constraint S_2
print 'The database was downgraded from version 2 to 1'
end 
go

create procedure v3 as
begin
create table USB(
ID_USB varchar(20) PRIMARY KEY,
GB int,
Name_Brand varchar(30)
);
print 'The database was upgraded from version 2 to 3'
end

create procedure v3_ as
begin
drop table USB
print 'The database was downgraded from version 3 to 2'
end
go


create procedure v4 as
begin 
alter table USB
add constraint fk_Name_Brand foreign key(Name_Brand) references Brand(Name_Brand);
print 'The database was upgraded from version 3 to 4'
end
go

create procedure v4_ as
begin 
alter table USB
drop constraint fk_Name_Brand
print 'The database was downgraded from version 4 to 3'
end
go

create procedure version_change
@version int
as
begin
if @version>4 or @version<0
begin
raiserror('The number you introduced doesnt represent an existing version, please enter an existing one.', 12, 1);
return;
end
else
declare @a int;
select @a= ver from version_ where sct=1
if @version>@a
begin
while @version>@a
if @a=0 begin exec v1; set @a=@a+1; end
else if @a=1 begin exec v2; set @a=@a+1; end
else if @a=2 begin exec v3; set @a=@a+1; end
else if @a=3 begin exec v4; set @a=@a+1; end
end

if @version<@a
begin
while @version<@a
if @a=4 begin exec v4_; set @a=@a-1; end
else if @a=3 begin exec v3_; set @a=@a-1; end
else if @a=2 begin exec v2_; set @a=@a-1; end
else if @a=1 begin exec v1_; set @a=@a-1; end
end
update version_
set ver=@version
end
go


exec version_change 0




