
drop table [IMDB_DB].[dbo].[title.principals];
drop table [IMDB_DB].[dbo].[staging.title.principals];

create table [IMDB_DB].[dbo].[title.principals]
(
	tconst varchar(10) not null
	, ordering varchar(5) not null
	, nconst varchar(10) not null
	, category varchar(20) not null
	, job varchar(300)
	, characters varchar(500)
);

create table [IMDB_DB].[dbo].[staging.title.principals]
(
	tconst varchar(10) not null
	, ordering varchar(5) not null
	, nconst varchar(10) not null
	, category varchar(20) not null
	, job varchar(1000)
	, characters varchar(1000)
);

bulk insert [IMDB_DB].[dbo].[staging.title.principals]
from 'PathTo\title.principals.tsv'
with (
	formatfile = 'PathTo\title.principals.xml',
	fieldterminator = '\t',
	rowterminator = '0x0a',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

update [IMDB_DB].[dbo].[staging.title.principals]
set job = null
where job = '\N'

update [IMDB_DB].[dbo].[staging.title.principals]
set characters = null
where characters = '\N'

insert into [IMDB_DB].[dbo].[title.principals]
( 
	tconst
	, ordering
	, nconst
	, category
	, job
	, characters
)
select 
	tconst
	, ordering
	, nconst
	, category
	, job
	, characters
from [IMDB_DB].[dbo].[staging.title.principals]
