CREATE TABLE IF NOT EXISTS nodes(point1 char NOT NULL,
								point2 char NOT NULL,
								cost int NOT NULL);
INSERT INTO nodes(point1, point2, cost)
VALUES ('A', 'B', 10), 
	   ('B', 'A', 10),
	   ('A', 'C', 15),
	   ('C', 'A', 15),
	   ('A', 'D', 20),
	   ('D', 'A', 20),
	   ('B', 'C', 35),
	   ('C', 'B', 35),
	   ('B', 'D', 25),
	   ('D', 'B', 25),
	   ('C', 'D', 30),
	   ('D', 'C', 30);
	   
WITH RECURSIVE tmp AS
        (SELECT point2, ('{' || point1) AS way, cost AS total_cost
         FROM nodes
         WHERE point1 = 'A'
         UNION
         SELECT nodes.point2, (tmp.way || ',' || nodes.point1) AS way, tmp.total_cost + nodes.cost AS total_cost
         FROM nodes
         JOIN tmp ON tmp.point2 = nodes.point1
         WHERE way NOT LIKE ('%' || nodes.point1 || '%')), 
		 tours AS (SELECT total_cost, (way || ',A}') AS tour 
				  FROM tmp
				  WHERE point2 = 'A' AND LENGTH(way) = 8),
		 min_tours AS (SELECT *
					  FROM tours
					  WHERE total_cost = (SELECT MIN(total_cost) FROM tours))

SELECT *
FROM min_tours
ORDER BY total_cost, tour;