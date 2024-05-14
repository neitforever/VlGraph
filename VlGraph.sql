USE MASTER
GO
DROP DATABASE IF EXISTS VlGraph
GO
CREATE DATABASE VlGraph
GO
USE VlGraph
GO

-- Создание таблицы Публикация
CREATE TABLE Publication (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Year INT,
    Topic VARCHAR(255)
) AS NODE;

-- Создание таблицы Автор
CREATE TABLE Author (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    LastName VARCHAR(100),
    Affiliation VARCHAR(255)
) AS NODE;

-- Создание таблицы Журнал
CREATE TABLE Journal (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    ISSN VARCHAR(20),
    Publisher VARCHAR(255)
) AS NODE;

CREATE TABLE Writes ([date] date ) AS EDGE
CREATE TABLE Works AS EDGE
CREATE TABLE Publishes ([date] date ) AS EDGE

-- Заполнение таблицы Публикация данными
INSERT INTO Publication (ID, Name, Year, Topic)
VALUES
    (1, 'Publication 1', 2021, 'Topic A'),
    (2, 'Publication 2', 2020, 'Topic B'),
    (3, 'Publication 3', 2019, 'Topic C'),
    (4, 'Publication 4', 2018, 'Topic D'),
    (5, 'Publication 5', 2017, 'Topic E'),
    (6, 'Publication 6', 2016, 'Topic F'),
    (7, 'Publication 7', 2015, 'Topic G'),
    (8, 'Publication 8', 2014, 'Topic H'),
    (9, 'Publication 9', 2013, 'Topic I'),
    (10, 'Publication 10', 2012, 'Topic J');

-- Заполнение таблицы Автор данными
INSERT INTO Author (ID, Name, LastName, Affiliation)
VALUES
    (1, 'John', 'Smith', 'University A'),
    (2, 'Jane', 'Doe', 'University B'),
    (3, 'Michael', 'Johnson', 'University C'),
    (4, 'Emily', 'Brown', 'University D'),
    (5, 'Chris', 'Wilson', 'University E'),
    (6, 'Sarah', 'Lee', 'University F'),
    (7, 'Alex', 'Clark', 'University G'),
    (8, 'Emma', 'Taylor', 'University H'),
    (9, 'Daniel', 'Martinez', 'University I'),
    (10, 'Olivia', 'Garcia', 'University J');

-- Заполнение таблицы Журнал данными
INSERT INTO Journal (ID, Name, ISSN, Publisher)
VALUES
    (1, 'Journal 1', '1234-5678', 'Publisher A'),
    (2, 'Journal 2', '2345-6789', 'Publisher B'),
    (3, 'Journal 3', '3456-7890', 'Publisher C'),
    (4, 'Journal 4', '4567-8901', 'Publisher D'),
    (5, 'Journal 5', '5678-9012', 'Publisher E'),
    (6, 'Journal 6', '6789-0123', 'Publisher F'),
    (7, 'Journal 7', '7890-1234', 'Publisher G'),
    (8, 'Journal 8', '8901-2345', 'Publisher H'),
    (9, 'Journal 9', '9012-3456', 'Publisher I'),
    (10, 'Journal 10', '0123-4567', 'Publisher J');


INSERT INTO Works ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Author WHERE id = 1),
 (SELECT $node_id FROM Author WHERE id = 2)),
 ((SELECT $node_id FROM Author WHERE id = 10),
 (SELECT $node_id FROM Author WHERE id = 5)),
 ((SELECT $node_id FROM Author WHERE id = 2),
 (SELECT $node_id FROM Author WHERE id = 9)),
 ((SELECT $node_id FROM Author WHERE id = 3),
 (SELECT $node_id FROM Author WHERE id = 1)),
 ((SELECT $node_id FROM Author WHERE id = 3),
 (SELECT $node_id FROM Author WHERE id = 6)),
 ((SELECT $node_id FROM Author WHERE id = 4),
 (SELECT $node_id FROM Author WHERE id = 2)),
 ((SELECT $node_id FROM Author WHERE id = 5),
 (SELECT $node_id FROM Author WHERE id = 4)),
 ((SELECT $node_id FROM Author WHERE id = 6),
 (SELECT $node_id FROM Author WHERE id = 7)),
 ((SELECT $node_id FROM Author WHERE id = 6),
 (SELECT $node_id FROM Author WHERE id = 8)),
 ((SELECT $node_id FROM Author WHERE id = 8),
 (SELECT $node_id FROM Author WHERE id = 3));

 INSERT INTO Publishes ($from_id, $to_id, [date])
VALUES ((SELECT $node_id FROM Journal WHERE ID = 1),
 (SELECT $node_id FROM Publication WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 5),
 (SELECT $node_id FROM Publication WHERE ID = 1), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 8),
 (SELECT $node_id FROM Publication WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 2),
 (SELECT $node_id FROM Publication WHERE ID = 2), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 3),
 (SELECT $node_id FROM Publication WHERE ID = 3), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 4),
 (SELECT $node_id FROM Publication WHERE ID = 3), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 6),
 (SELECT $node_id FROM Publication WHERE ID = 4), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 7),
 (SELECT $node_id FROM Publication WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 1),
 (SELECT $node_id FROM Publication WHERE ID = 9), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 9),
 (SELECT $node_id FROM Publication WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Journal WHERE ID = 10),
 (SELECT $node_id FROM Publication WHERE ID = 9), '2022-07-05 14:30:00');

 INSERT INTO Writes ($from_id, $to_id, [date])
VALUES ((SELECT $node_id FROM Author WHERE ID = 1),
 (SELECT $node_id FROM Publication WHERE ID = 6), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 5),
 (SELECT $node_id FROM Publication WHERE ID = 1), '2021-09-05 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 8),
 (SELECT $node_id FROM Publication WHERE ID = 7), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 2),
 (SELECT $node_id FROM Publication WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 3),
 (SELECT $node_id FROM Publication WHERE ID = 5), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 4),
 (SELECT $node_id FROM Publication WHERE ID = 3), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 6),
 (SELECT $node_id FROM Publication WHERE ID = 4), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 7),
 (SELECT $node_id FROM Publication WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 1),
 (SELECT $node_id FROM Publication WHERE ID = 9), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 9),
 (SELECT $node_id FROM Publication WHERE ID = 8), '2021-11-05 09:45:00'),
 ((SELECT $node_id FROM Author WHERE ID = 10),
 (SELECT $node_id FROM Publication WHERE ID = 9), '2021-11-10 09:45:00');

 SELECT A.name, P.name
FROM Author AS A
	, Writes AS w
	, Publication AS P
WHERE MATCH(A-(w)->P)
AND P.name = 'Publication 9';

 SELECT A.name, P.name
FROM Author AS A
	, Writes AS w
	, Publication AS P
WHERE MATCH(A-(w)->P)
AND W.date > '2021-10-09 14:30:00';

SELECT j.name, pb.name
FROM Journal j
	, Publishes p
	, Publication pb
WHERE MATCH(j-(p)->pb)
AND p.date > '2022-06-09 14:30:00';

SELECT j.name, pb.name
FROM Journal j
	, Publishes p
	, Publication pb
WHERE MATCH(j-(p)->pb)
AND j.name = 'Journal 1';

 SELECT A1.name, A2.name
FROM Author AS A1
	, Works AS w
	, Author AS A2
WHERE MATCH(A1-(w)->A2)
AND A1.name = 'Sarah';

SELECT Author1.name AS PersonName
 , STRING_AGG(Author2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Coworkers
FROM Author AS Author1
 , Works FOR PATH AS w
 , Author FOR PATH AS Author2
WHERE MATCH(SHORTEST_PATH(Author1(-(w)->Author2)+))
 AND Author1.name = 'Michael';

 SELECT Author1.name AS PersonName
 , STRING_AGG(Author2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Coworkers
FROM Author AS Author1
 , Works FOR PATH AS w
 , Author FOR PATH AS Author2
WHERE MATCH(SHORTEST_PATH(Author1(-(w)->Author2){1,3}))
 AND Author1.name = 'Sarah';

  SELECT Author1.id AS IdFirst
	, Author1.name AS First
	, CONCAT(N'author (', Author1.id, ')') AS [First image name]
	, Author2.id AS IdSecond
	, Author2.name AS Second
	, CONCAT(N'author (', Author2.id, ')') AS [Second image name]
FROM Author AS Author1
 , Works AS w
 , Author AS Author2
WHERE MATCH(Author1-(w)->Author2);

  SELECT A.id AS IdFirst
	, A.name AS First
	, CONCAT(N'author (', A.id, ')') AS [First image name]
	, P.id AS IdSecond
	, P.name AS Second
	, CONCAT(N'publication (', P.id, ')') AS [Second image name]
FROM Author AS A
 , Writes AS w
 , Publication AS P
WHERE MATCH(A-(w)->P);

  SELECT J.id AS IdFirst
	, J.name AS First
	, CONCAT(N'journal (', J.id, ')') AS [First image name]
	, P.id AS IdSecond
	, P.name AS Second
	, CONCAT(N'publication (', P.id, ')') AS [Second image name]
FROM Journal AS J
 , Publishes AS ps
 , Publication AS P
WHERE MATCH(J-(ps)->P);

Select @@servername