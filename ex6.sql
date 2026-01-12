SELECT a.primaryName, count(DISTINCT(b.category)) 
FROM dbo.tArtist as a 
JOIN dbo.tJob as b ON a.idArtist = b.idArtist 
GROUP BY b.idArtist, a.primaryName 
HAVING COUNT(DISTINCT(b.category)) > 1