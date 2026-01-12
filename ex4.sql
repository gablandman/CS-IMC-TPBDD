SELECT TOP 1 birthYear, count(birthYear) 
FROM dbo.tArtist 
WHERE birthYear != 0
GROUP BY birthYear 
ORDER BY count(birthYear) DESC