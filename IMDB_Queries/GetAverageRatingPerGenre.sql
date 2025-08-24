
create procedure GetAverageRatingPerGenre
as
begin
	select
		distinct tb.genres
		, avg(tr.averageRating) as averageRating
		, count(*) as numMovies
	from [IMDB_DB].[dbo].[title.basics] as tb
	left join [IMDB_DB].[dbo].[title.ratings] as tr on tr.tconst = tb.const
	where tb.genres != '\N'
		and tb.titleType = 'Movie'
	group by tb.genres
	order by averageRating desc
end

execute GetAverageRatingPerGenre
