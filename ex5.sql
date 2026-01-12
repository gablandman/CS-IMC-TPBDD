SELECT a.primaryName, count(*)
FROM dbo.tArtist as a 
JOIN dbo.tJob as b 
ON a.idArtist = b.idArtist 
GROUP BY a.primaryName 
HAVING count(*) > 1
