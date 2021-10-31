create table usersdata --User Table
(
	userid nvarchar(50) primary key,
	username nvarchar(50),
	usertype nvarchar(50),
	passwd varbinary(100)
)
create table sesdata
(
	sesid int,
	userid nvarchar(50) unique references usersdata(userid),
	logstatus bit default 0
)
--MASTER SETUP
create table acsetup --Account Setup
(
	stallname nvarchar(50),
	cont_no1 nvarchar(50) unique,
	cont_no2 nvarchar(50),
	country nvarchar(50),
	statenm nvarchar(50),
	dist nvarchar(50),
	ps nvarchar(50),
	vill nvarchar(50),
	pin nvarchar(50),
	panno nvarchar(50),
	gstno nvarchar(50),
	liecenceno nvarchar(50),
	statecode nvarchar(50),
	email nvarchar(50),
	website nvarchar(50),
)
create table banksetup --Bank Setup
(
	holder_name nvarchar(50),
	bank_name nvarchar(50),
	actype nvarchar(50),
	acno nvarchar(50) primary key,
	ifsc nvarchar(50),
	micr nvarchar(50),
	brunch nvarchar(50),
	addrs nvarchar(200),
	remark nvarchar(200)
)
create table partysetup --Party Setup
(
	party_id nvarchar(50) primary key,
	pt_name nvarchar(50),
	pt_type nvarchar(50),
	addrs nvarchar(200),
	cont_no nvarchar(50),
	email nvarchar(50),
	pan_no nvarchar(50),
	gst_no nvarchar(50),
	statecode nvarchar(50),
	payment_mode nvarchar(50),
	details nvarchar(200),
	remark nvarchar(200)
)
create table itemsetup --Item Setup
(
	book_name nvarchar(100),
	isbn_code nvarchar(50) primary key,
	pub_comp nvarchar(200),
	gst nvarchar(50),
	cgst nvarchar(50),
	sgst nvarchar(50),
	remark nvarchar(200)
)
create table purchase --Purchase
(
	book_name nvarchar(50),
	isbn_code nvarchar(50) foreign key references itemsetup(isbn_code),
	hsn_code nvarchar(50),
	pub_comp nvarchar(200),
	purchs_from nvarchar(200),
	edition nvarchar(50),
	genre nvarchar(50),
	class nvarchar(50),
	mrp nvarchar(50),
	rate nvarchar(50),
	qty nvarchar(50),
	selling_rate nvarchar(50),
	gst nvarchar(50),
	cgst nvarchar(50),
	sgst nvarchar(50),
	sortinqty nvarchar(50)
)
--SELL
create table sell_dtls --Sell Details
(
	invoice_no nvarchar(50) primary key,
	invoice_dt date,
	order_no nvarchar(50) unique,
	order_dt date,
	name nvarchar(50),
	cont_no nvarchar(50),
	gst_no nvarchar(50),
	statename nvarchar(50),
	addrs nvarchar(50),
	email nvarchar(50),
	pan nvarchar(50)
)
create table sell_item --Sell Items
(
	invoice_no nvarchar(50) foreign key references sell_dtls,
	isbn_code nvarchar(50) foreign key references sell_dtls,
	selling_rate nvarchar(50),
	qty nvarchar(50),
	amount nvarchar(50),
	retun bit default 0
)
create table sell_amount --Sell Amount
(
	invoice_no nvarchar(50) foreign key references sell_dtls,
	totl_itm nvarchar(50),
	amount nvarchar(50),
	cgst nvarchar(50),
	sgst nvarchar(50),
	net_amount nvarchar(50),
	discount nvarchar(50),
	totl_amount nvarchar(50),
	paid_by nvarchar(50),
	paid_amount nvarchar(50),
	due nvarchar(50),
	retun bit default 0
)
--TRANSACTION
create table cust_payment --Customer Payment
(
	invoice_no nvarchar(50) foreign key references sell_dtls,
	paid_amount nvarchar(50),
	due_amount nvarchar(50),
	now_paying nvarchar(50),
	pay_date date,
	remark nvarchar(200)
)
create table party_payment --Party Payment
(
	party_id nvarchar(50) foreign key references partysetup,
	pt_invoiceno nvarchar(50),
	pt_name nvarchar(50),
	billing_dt date,
	tot_amount nvarchar(50),
	paid_amount nvarchar(50),
	due nvarchar(50),
	now_paying nvarchar(50),
	dt date,
	remark nvarchar(200)
)
create table expence --Expence
(
	discription nvarchar(200),
	amount nvarchar(50),
	dt date,
	ex_rmrk nvarchar(200)
)


--Party setup
create proc procpartysetup @party_id nvarchar(50), @pt_name nvarchar(50),@pt_type nvarchar(50),@addrs nvarchar(200), @cont_no nvarchar(50),@email nvarchar(50), @pan_no nvarchar(50), @gst_no nvarchar(50), @statecode nvarchar(50), @payment_mode nvarchar(50), @details nvarchar(200), @remark nvarchar(200)
as
begin
insert into partysetup values(@party_id, @pt_name, @pt_type, @addrs, @cont_no, @email, @pan_no, @gst_no, @statecode, @payment_mode, @details, @remark)
end

--party setup id generate
create proc genpartyid @newid nvarchar(50) output
as
declare @n as  int 
--set @n = (select top 1 cast(SUBSTRING(party_id, 4, 50) as int ) from partysetup order by party_id desc)

set @n = @n+1
if @n>=10
	set @newid = (select 'PAR' + CONVERT(nvarchar(50), @n))
else
	set @newid = (select 'PAR0' + CONVERT(nvarchar(50), @n))	
go	

--itemsetup
create proc procitemsetup @book_name nvarchar(100), @isbn_code nvarchar(50),@pub_comp nvarchar(200),@gst nvarchar(50), @cgst nvarchar(50),@sgst nvarchar(50), @remark nvarchar(200)
as
begin
insert into itemsetup values(@book_name, @isbn_code, @pub_comp, @gst, @cgst, @sgst, @remark)
end


exec procitemsetup 'codershub', '1234', 'minsar', ' ',' ',' ',' '
select * from itemsetup


select * from purchase
insert into purchase (book_name, isbn_code) values('coderrhub', '1234')


