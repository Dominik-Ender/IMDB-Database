
drop table [IMDB_DB].[dbo].[title.akas];
drop table [IMDB_DB].[dbo].[staging.title.akas];

create table [IMDB_DB].[dbo].[title.akas]
(
	titleId varchar(15) not null
	, ordering varchar(5) not null
	, title varchar(1000) not null
	, region varchar(10)
	, language varchar(5)
	, types varchar(25)
	, attributes varchar(100)
	, isOriginalTitle varchar(2) not null
);

create table [IMDB_DB].[dbo].[staging.title.akas]
(	
	titleId varchar(50)
	, ordering varchar(50)
	, title varchar(1000)
	, region varchar(50)
	, language varchar(50)
	, types varchar(50)
	, attributes varchar(500)
	, isOriginalTitle varchar(5)
);

drop table [IMDB_DB].[dbo].[title.akas]
drop table [IMDB_DB].[dbo].[staging.title.akas]

bulk insert [IMDB_DB].[dbo].[staging.title.akas]
from 'PathTo\title.akas.tsv'
with (
	formatfile = 'PathTo\title.akas.xml',
	fieldterminator = '\t',
	rowterminator = '0x0a',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

update [IMDB_DB].[dbo].[staging.title.akas]
set region = null
where region = '\N'

update [IMDB_DB].[dbo].[staging.title.akas]
set language = null
where language = '\N'

update [IMDB_DB].[dbo].[staging.title.akas]
set types = null
where types = '\N'

update [IMDB_DB].[dbo].[staging.title.akas]
set attributes = null
where attributes = '\N'

insert into [IMDB_DB].[dbo].[title.akas]
( 
	titleId
	, ordering
	, title
	, region
	, language
	, types
	, attributes
	, isOriginalTitle
)
select 
	titleId
	, ordering
	, title
	, region
	, language
	, types
	, attributes
	, isOriginalTitle
from [IMDB_DB].[dbo].[staging.title.akas]
