
create procedure GetHighestRatingOfActor
	@actor varchar(100)
as
begin
	select
		tb.primaryTitle
		, tr.averageRating
	from [IMDB_DB].[dbo].[title.basics] as tb 
	join [IMDB_DB].[dbo].[title.ratings] as tr on tr.tconst = tb.const
	where exists (select
						nb.primaryName
					from [IMDB_DB].[dbo].[name.basics] as nb
					cross apply string_split(nb.knownForTitles, ',') s
					where nb.primaryName = @actor
						and tb.const = s.value)
	order by tr.averageRating desc
end;

execute GetHighestRatingOfActor @actor = 'Brad Pitt'
