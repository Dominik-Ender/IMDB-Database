
drop table [IMDB_DB].[dbo].[title.crew];
drop table [IMDB_DB].[dbo].[staging.title.crew;

create table [IMDB_DB].[dbo].[title.crew]
(
	tconst varchar(10) not null
	, directors varchar(5500) 
	, writers varchar(max)
);

create table [IMDB_DB].[dbo].[staging.title.crew]
(
	tconst varchar(50) not null
	, directors varchar(5500)
	, writers varchar(max)
);

drop table [IMDB_DB].[dbo].[title.crew]
drop table [IMDB_DB].[dbo].[staging.title.crew]

bulk insert [IMDB_DB].[dbo].[staging.title.crew]
from 'PathTo\title.crew.tsv'
with (
	formatfile = 'PathTo\title.crew.xml',
	fieldterminator = '\t',
	rowterminator = '0x0a',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

insert into [IMDB_DB].[dbo].[title.crew]
( 
	tconst
	, directors
	, writers
)
select 
	tconst
	, directors
	, writers
from [IMDB_DB].[dbo].[staging.title.crew]
