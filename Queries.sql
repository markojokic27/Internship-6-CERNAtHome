--●	naziv i datum objave svakog znanstvenog rada zajedno s imenima znanstvenika koji su na njemu radili, pri čemu imena znanstvenika moraju biti u jednoj ćeliji i u obliku Prezime, I.; npr. Puljak, I.; Godinović, N.; Bilušić, A.
SELECT sw.Name, sw.Created, 
	(SELECT STRING_AGG(CONCAT(s.Surname,' ,',LEFT(s.Name,1),'.'),'; ')  FROM Scientists s
	 WHERE(SELECT COUNT(*) FROM WorksScientists ws
		 WHERE ws.ScientistId = s.ScientistId AND sw.WorkId = ws.WorkId) > 0) AS Authors
FROM  ScientificWorks sw

--●	ime, prezime, spol (ispisati ‘MUŠKI’, ‘ŽENSKI’, ‘NEPOZNATO’, ‘OSTALO’;), ime države i  PPP/capita iste svakom znanstveniku
SELECT s.Name, s.Surname,
CASE 
WHEN s.Gender = 'MUŠKI' THEN 'MUŠKI'
WHEN s.Gender = 'ŽENSKI' THEN 'ŽENSKI'
WHEN s.Gender = 'OSTALO' THEN 'OSTALO'
WHEN s.Gender = 'NEPOZNATO' THEN 'NEPOZNATO'
END AS Gender,c.Name AS Country, c.PPP
FROM Scientists s
JOIN Countries c ON c.CountryId = s.CountryId

--●	svaku kombinaciju projekta i akceleratora, pri čemu nas zanimaju samo nazivi; u slučaju da projekt nije vezan ni za jedan akcelerator, svejedno ga ispiši uz ime akceleratora ‘NEMA GA’.
SELECT p.Name AS Project_Name,
CASE 
WHEN (SELECT COUNT(*) FROM ProjectsAccelerators pa WHERE pa.ProjectId = p.ProjectId) > 0
THEN a.Name
ELSE 'NEMA GA'
END
AS Accelerator_Name
FROM Projects p
LEFT JOIN ProjectsAccelerators pa ON pa.Projectid = p.Projectid
LEFT JOIN Accelerators a ON pa.AcceleratorId = a.AcceleratorId

--●	sve projekte kojima je bar jedan od radova izašao između 2015. i 2017.
SELECT DISTINCT p.Name FROM Projects p
JOIN ScientificWorks sw ON sw.ProjectId = p.ProjectId
WHERE  
	DATE_PART('year', sw.created) BETWEEN 2015 AND 2017
	
--●	u istoj tablici po zemlji broj radova i najpopularniji rad znanstvenika iste zemlje, pri čemu je najpopularniji rad onaj koji ima najviše citata
SELECT c.Name AS Country, s.Surname AS Scientist, COUNT(*) AS WorksNumber, 
(SELECT sw.Name FROM ScientificWorks sw
JOIN WorksScientists ws ON sw.WorkId = ws.WorkId
WHERE ws.ScientistId = s.ScientistId AND c.CountryId = s.CountryId
GROUP BY sw.Name, sw.CitationsNumber
ORDER BY sw.CitationsNumber DESC
LIMIT 1)
AS PopularWork FROM ScientificWorks sw
JOIN WorksScientists ws ON sw.WorkId = ws.WorkId
JOIN Scientists s ON s.ScientistId = ws.ScientistId 
JOIN Countries c ON c.CountryId = s.CountryId
GROUP BY c.CountryId, s.ScientistId
ORDER BY c.Name, s.Surname

--●	prvi objavljeni rad po svakoj zemlji
SELECT c.Name as Country,COALESCE((SELECT sw.Name AS Work FROM  ScientificWorks sw
JOIN  WorksScientists ws ON ws.WorkId = ws.WorkId
JOIN Scientists s ON s.ScientistId = ws.ScientistId
WHERE s.CountryId = c.CountryId
ORDER BY sw.Created
LIMIT 1), 'NEMA GA')
AS FirstWork
FROM Countries c

--●	gradove po broju znanstvenika koji trenutno u njemu borave
SELECT c.Name AS City, COALESCE((SELECT COUNT(*)  
FROM Scientists s 
JOIN Hotels h ON h.HotelId = s.HotelId
WHERE h.HotelId = s.HotelId and h.CityId = c.CityId), 0)
AS ScientistsNumber
FROM Cities c
ORDER BY ScientistsNumber DESC

--●	prosječan broj citata radova po svakom akceleratoru
SELECT a.Name AS Accelerator, COALESCE((SELECT ROUND(AVG(sw.CitationsNumber),2)
FROM  ScientificWorks sw
JOIN Projects p ON p.ProjectId = sw.ProjectId
JOIN ProjectsAccelerators pa ON pa.ProjectId = p.ProjectId
WHERE sw.ProjectId = pa.ProjectId AND a.AcceleratorId = pa.AcceleratorId), 0)
AS AverageCitationsNumber 
FROM Accelerators a

--●	broj znanstvenika po struci, desetljeću rođenja i spolu; u slučaju da je broj znanstvenika manji od 20, ne prikazuj kategoriju; poredaj prikaz po desetljeću rođenja
SELECT SUBSTRING(CAST(DATE_PART('year', s.Birth) AS VARCHAR), 1, 3) AS Decade, s.Profession, 
CASE
WHEN s.Gender = 'MUŠKI' THEN 'MUŠKI'
WHEN s.Gender = 'ŽENSKI' THEN 'ŽENSKI'
WHEN s.Gender = 'OSTALO' THEN 'OSTALO'
WHEN s.Gender = 'NEPOZNATO' THEN 'NEPOZNATO'
END
AS Gender, COUNT(*) AS NumberPerCategory
FROM Scientists s
GROUP BY s.Profession, Decade, s.Gender
HAVING COUNT(*) >= 20
ORDER BY Decade