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
					   WHERE total_cost = (SELECT MIN(total_cost) FROM tours)),
		 max_tours AS (SELECT *
					   FROM tours
					   WHERE total_cost = (SELECT MAX(total_cost) FROM tours))

SELECT *
FROM min_tours
UNION
SELECT *
FROM max_tours
ORDER BY total_cost, tour;