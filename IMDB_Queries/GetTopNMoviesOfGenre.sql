
create procedure GetTopNMoviesOfGenre
	@genre varchar(50)
	, @n int
as 
begin
	select top(@n)
		tb.genres
		, tb.primaryTitle
		, tr.averageRating
		, tr.numVotes
	from [IMDB_DB].[dbo].[title.basics] as tb
	left join [IMDB_DB].[dbo].[title.ratings] as tr on tr.tconst = tb.const
	where tb.genres like '%' + @genre + '%' 
		and tr.numVotes > 50000
		and tb.titleType = 'Movie'
	order by tr.averageRating desc, tr.numVotes desc
end

execute GetTopNMoviesOfGenre @genre = 'Action', @n = 20
