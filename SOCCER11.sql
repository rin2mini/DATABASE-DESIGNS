create table players(
ID nvarchar(30),
NAME nvarchar(50),
AGE int,
POSITION nvarchar(30),
SALARY int
);

insert into players values('50', 'donnarumma', 22, 'goalkeeper', '10000')
insert into players values('1', 'navas', 17, 'goalkeeper', '10000')
insert into players values('2', 'hakimi', 22, 'defender', '15000')
insert into players values('4', 'ramos', 32, 'defender', '30000')
insert into players values('20', 'kurzawa', 23, 'defender', '12000')
insert into players values('6', 'marco', 26, 'midfielder', '15000')
insert into players values('11', 'dimaria', 32, 'midfielder', '22000')
insert into players values('34', 'simons', 27, 'midfielder', '20000')
insert into players values('7', 'mbappe', 23, 'forward', '30000')
insert into players values('10', 'neymar', 29, 'forward', '30000')
insert into players values('30', 'messi', 34, 'forward', '50000')
insert into players values('10', 'messi', 34, 'forward', '50000')
select * from players

select name, position from players
select * from players where POSITION='forward'
select *from players where position like '%der'
delete players where NAME='messi' and ID=10
select count(distinct age) from players
select * from players where ID between 10 and 30
select * from players where POSITION in('defender','forward')



