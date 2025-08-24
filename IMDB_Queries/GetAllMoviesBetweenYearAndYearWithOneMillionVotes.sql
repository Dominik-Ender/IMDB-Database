
create procedure GetAllMoviesBetweenYearAndYearWithOneMillionVotes
	@yearOne varchar(4)
	, @yearTwo varchar(4)
as
begin
	select top(20)
		b.primaryTitle
		, r.averageRating
		, r.numVotes
		, b.startYear
	from [IMDB_DB].[dbo].[title.basics] as b
	left join [IMDB_DB].[dbo].[title.ratings] as r on b.const = r.tconst
	where b.titleType = 'Movie'
		and b.startYear between @yearOne and @yearTwo
		and r.numVotes >= 1000000
	order by r.averageRating desc;
end

execute GetAllMoviesBetweenYearAndYearWithOneMillionVotes @yearOne = '2011', @yearTwo = '2015'