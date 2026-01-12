SELECT a.primaryName, f.primaryTitle
FROM dbo.tArtist a
JOIN dbo.tJob b ON a.idArtist = b.idArtist
JOIN dbo.tFilm f ON b.idFilm = f.idFilm
GROUP BY a.idArtist, a.primaryName, f.primaryTitle, b.idFilm
HAVING COUNT(DISTINCT b.category) > 1;
