	
drop table [IMDB_DB].[dbo].[title.basics];
drop table [IMDB_DB].[dbo].[staging.title.basics];

create table [IMDB_DB].[dbo].[title.basics]
(
	const varchar(10) not null
	, titleType varchar(20) not null
	, primaryTitle varchar(600) not null
	, originalTitle varchar(600) not null
	, isAdult varchar(2) not null
	, startYear int
	, endYear int
	, runtimeMinutes int
	, genres varchar(60) not null
);

create table [IMDB_DB].[dbo].[staging.title.basics]
(
	const varchar(max) not null
	, titleType varchar(max) 
	, primaryTitle varchar(max)
	, originalTitle varchar(max) 
	, isAdult varchar(max)
	, startYear varchar(max)
	, endYear varchar(max)
	, runtimeMinutes varchar(max)
	, genres varchar(max)
);

bulk insert [IMDB_DB].[dbo].[staging.title.basics]
from 'PathTo\title.basics.tsv'
with (
	formatfile = 'PathTo\title.basics.xml',
	fieldterminator = '\t',
	rowterminator = 'n',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

update [IMDB_DB].[dbo].[staging.title.basics]
set startYear = NULL
where startYear = '\N'

update [IMDB_DB].[dbo].[staging.title.basics]
set endYear = NULL
where endYear = '\N'

update [IMDB_DB].[dbo].[staging.title.basics]
set runtimeMinutes = null
where runtimeMinutes = '\N'

insert into [IMDB_DB].[dbo].[title.basics] (
    const
	, titleType
	, primaryTitle
	, originalTitle 
	, isAdult
	, startYear
	, endYear
	, runtimeMinutes
	, genres
)
select
    const
	, titleType
	, primaryTitle
	, originalTitle 
	, try_cast(isAdult as int)
	, try_cast(startYear as int)
	, try_cast(endYear as int)
	, try_cast(runtimeMinutes as int)
	, genres
from [IMDB_DB].[dbo].[staging.title.basics];
