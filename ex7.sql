SELECT primaryTitle
FROM dbo.tFilm
WHERE idFilm = (
    SELECT TOP 1 b.idFilm
    FROM dbo.tJob AS b
    WHERE b.category = 'ACTED IN'
    GROUP BY b.idFilm
    ORDER BY COUNT(b.idArtist) DESC
);
