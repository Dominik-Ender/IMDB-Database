
drop table [IMDB_DB].[dbo].[title.episode]
drop table [IMDB_DB].[dbo].[staging.title.episode]

create table [IMDB_DB].[dbo].[title.episode]
(
	tconst varchar(10) not null
	, parentTconst varchar(10) not null
	, seasonNumber smallint
	, episodeNumber smallint
);

create table [IMDB_DB].[dbo].[staging.title.episode]
(
	tconst varchar(50) not null
	, parentTconst varchar(10) not null
	, seasonNumber varchar(50)
	, episodeNumber varchar(50)
);

drop table [IMDB_DB].[dbo].[staging.title.episode]

bulk insert [IMDB_DB].[dbo].[staging.title.episode]
from 'PathTo\title.episode.tsv'
with (
	formatfile = 'PathTo\title.episode.xml',
	fieldterminator = '\t',
	rowterminator = '0x0a',
	firstrow = 2,
	codepage = '65001',
	keepnulls
);

update [IMDB_DB].[dbo].[staging.title.episode]
set seasonNumber = null
where seasonNumber = '\N'

update [IMDB_DB].[dbo].[staging.title.episode]
set episodeNumber = null
where episodeNumber = '\N'

insert into [IMDB_DB].[dbo].[title.episode]
( 
	tconst
	, parentTconst
	, seasonNumber
	, episodeNumber
)
select 
	tconst
	, parentTconst
	, try_cast(seasonNumber as smallint)
	, try_cast(episodeNumber as smallint)
from [IMDB_DB].[dbo].[staging.title.episode]



