
drop table [IMDB_DB].[dbo].[name.basics];
drop table [IMDB_DB].[dbo].[staging.name.basics];

create table [IMDB_DB].[dbo].[name.basics]
(
	nconst varchar(10) not null
	, primaryName varchar(120) 
	, birthyear smallint
	, deathyear smallint
	, primaryProfession varchar(70)
	, knownForTitles varchar(50)
);

create table [IMDB_DB].[dbo].[staging.name.basics]
(
	nconst varchar(25) not null
	, primaryName varchar(120) 
	, birthyear varchar(10)
	, deathyear varchar(10)
	, primaryProfession varchar(70)
	, knownForTitles varchar(50)
);

bulk insert [IMDB_DB].[dbo].[staging.name.basics]
from 'PathTo\name.basics.tsv'
with (
	formatfile = 'PathTo\name.basics.xml',
	fieldterminator = '\t',
	rowterminator = 'n',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

update [IMDB_DB].[dbo].[staging.name.basics]
set birthYear = NULL
where birthYear = '\N'

update [IMDB_DB].[dbo].[staging.name.basics]
set deathYear = NULL
where deathYear = '\N'

update [IMDB_DB].[dbo].[staging.name.basics]
set nconst = 'nm0000001'
where primaryName = 'Fred Astaire' and birthyear = '1899'

insert into [IMDB_DB].[dbo].[name.basics] (
    nconst,
    primaryName,
    birthYear,
    deathYear,
    primaryProfession,
    knownForTitles
)
select
    nconst,
    primaryName,
    try_cast(birthYear as smallint),
    try_cast(deathYear as smallint),
    primaryProfession,
    knownForTitles
from [IMDB_DB].[dbo].[staging.name.basics];
