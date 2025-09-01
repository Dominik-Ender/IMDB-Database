
drop table [IMDB_DB].[dbo].[title.ratings];
drop table [IMDB_DB].[dbo].[staging.title.ratings];

create table [IMDB_DB].[dbo].[title.ratings]
(
	tconst varchar(10) not null
	, averageRating float
	, numVotes int
);

create table [IMDB_DB].[dbo].[staging.title.ratings]
(
	tconst varchar(50) not null
	, averageRating float
	, numVotes int
);

drop table [IMDB_DB].[dbo].[staging.title.ratings]

bulk insert [IMDB_DB].[dbo].[staging.title.ratings]
from 'PathTo\title.ratings.tsv'
with (
	formatfile = 'PathTo\title.ratings.xml',
	fieldterminator = '\t',
	rowterminator = '0x0a',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

insert into [IMDB_DB].[dbo].[title.ratings]
( 
	tconst
	, averageRating
	, numVotes
)
select 
	tconst
	, try_cast(averageRating as float)
	, try_cast(numVotes as int)
from [IMDB_DB].[dbo].[staging.title.ratings]
