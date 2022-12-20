CREATE TABLE Accelerators(
	AcceleratorId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE Projects(
	ProjectId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE ProjectsAccelerators(
	AcceleratorId INT REFERENCES Accelerators(AcceleratorId),
	ProjectId INT REFERENCES Projects(ProjectId),
	PRIMARY KEY(ProjectId, AcceleratorId)
);
CREATE TABLE ScientificWorks(
	WorkId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	ProjectId INT REFERENCES Projects(ProjectId) NOT NULL,
	CitationsNumber INT NOT NULL,
	Created TIMESTAMP NOT NULL
);
CREATE TABLE Countries(
	CountryId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE,
	Population INT NOT NULL,
	PPP FLOAT NOT NULL
);
CREATE TABLE Cities(
	CityId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE Hotels (
	HotelId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	CityId INT REFERENCES Cities(CityId) NOT NULL,
	Capacity INT NOT NULL
);
CREATE TABLE Scientists(
	ScientistId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Surname VARCHAR(30) NOT NULL,
	Birth TIMESTAMP NOT NULL,
	CountryId INT REFERENCES Countries(CountryId) NOT NULL,
	Gender VARCHAR(30) CHECK (Gender IN ('MUŠKI','ŽENSKI','NEPOZNATO','OSTALO')),
	Profession VARCHAR(30) CHECK (Profession IN ('programer', 'fizičar', 'inženjer', 'znanstvenik materijala')),
	HotelId INT REFERENCES Hotels(HotelId)
);
CREATE TABLE WorksScientists(
	WorkId INT REFERENCES ScientificWorks(WorkId),
	ScientistId INT REFERENCES Scientists(ScientistId),
	PRIMARY KEY(WorkId, ScientistId)
);




CREATE FUNCTION CheckHotel(HotelId INT)
RETURNS BOOLEAN AS
$$
DECLARE CapacityA INT;
BEGIN
SELECT SUM(HotelId) INTO CapacityA FROM Scientists;
IF CapacityA > (SELECT Capacity FROM Hotels WHERE Id = hotel_id) 
THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;
END;
$$
LANGUAGE plpgsql;

ALTER TABLE Scientists
ADD CONSTRAINT checkHotel CHECK (CheckHotel(HotelId));

INSERT INTO Accelerators(Name) VALUES
('LINAC'),
('PS'),
('LHC'),
('SPS')

SELECT * FROM Accelerators

INSERT INTO Projects(Name) VALUES
('Prvi projekt'),
('Drugi projekt'),
('Treci projekt'),
('Cetvrti projekt')

SELECT * FROM Projects

DELETE FROM Accelerators
where AcceleratorId=8

INSERT INTO ProjectsAccelerators(AcceleratorId,ProjectId)VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(4,1)
select * from ProjectsAccelerators

insert into ScientificWorks (Name,ProjectId,CitationsNumber,Created) values
('Istrazivanje kvarka',1,100,'2008-2-1'),
('Istrazivanje miona',1,5,'1992-5-9'),
('Istrazivanje kaona',2,27,'2011-2-10'),
('Istrazivanje piona',3,80,'2019-6-12'),
('Istrazivanje gravitona',4,200,'2022-1-1'),
('Istrazivanje bozona',4,14,'2016-9-9'),
('Istrazivanje neutrina',4,10,'2018-4-12')

select * from ScientificWorks

insert into Countries (Name,Population,PPP) values
('SAD',300000000,70480),
('Hrvatska',3800356,33900),
('Njemacka',60000400,80234),
('Japan',50345098,90221),
('Svicarska',20456321,89002),
('Italija',61342342,40234)

select * from Countries

insert into Cities(Name) values
('Ženeva'),
('Bern'),
('Basel'),
('Sion')

select * from Cities

insert into Hotels(Name,CityId,Capacity) values
('Hotel Dorian',1,30),
('Plazma Hotel',1,35),
('Central Motel',1,10),
('Hotel Geneve',1,20),
('Hotel Max',2,11),
('Dum Hotel',2,90),
('Hostel Ana',3,10),
('Cemex Hostel',4,50),
('Hotel Lusy',4,222)

Select * from hotels

insert into Scientists(Name,Surname,Birth,CountryId,Gender,Profession,HotelId) values
('Ivica','Puljak','1972-5-9',2,'MUŠKI','fizičar',1),
('Ante','Bartulovic','1976-5-9',2,'NEPOZNATO','programer',2),
('Anna','Smith','1996-5-9',1,'ŽENSKI','inženjer',4),
('Adolf','Muller','1988-5-9',3,'OSTALO','inženjer',7),
('Chin','Lee','1980-5-9',4,'OSTALO','znanstvenik materijala',6),
('Irina','Alfo','1960-5-9',5,'ŽENSKI','znanstvenik materijala',3)


Select * from Scientists

insert into WorksScientists (WorkId,ScientistId) values
(1,6),
(1,4),
(2,3),
(2,4),
(2,8),
(3,3),
(4,3),
(5,5),
(5,7),
(5,3),
(6,7),
(6,8),
(7,4),
(7,6)

select * from WorksScientists