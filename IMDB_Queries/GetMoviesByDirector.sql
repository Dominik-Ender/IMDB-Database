
create procedure GetMoviesByDirector 
	@director nvarchar(50)
as
begin
	select
		nb.primaryName
		, tb.primaryTitle
		, tb.genres
		, tr.numVotes
		, tr.averageRating
	from [IMDB_DB].[dbo].[title.basics] as tb
	left join [IMDB_DB].[dbo].[title.crew] as tc on tc.tconst = tb.const
	left join [IMDB_DB].[dbo].[name.basics] as nb on nb.nconst = tc.directors
	left join [IMDB_DB].[dbo].[title.ratings] as tr on tr.tconst = tb.const
	where nb.primaryName = @director
	order by tr.numVotes desc, tr.averageRating desc
end;

execute GetMoviesByDirector @director = 'Steven Spielberg'
