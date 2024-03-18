-- calcolo della distanza in chilometri da un parco definito rispetto piazza unità o un punto dato
-- dati piazza unità: longitude: 13.7673139, latitude: 45.6499975
-- sostituire le coordinate con un qualsiasi punto dato per scoprirne la distanza in linea d'aria dal parco al punto prestabilito

SELECT
(6371 * acos(
    cos(radians(latitude)) * cos(radians(45.6499975)) * cos(radians(longitude) - radians(13.7673139)) + sin(radians(latitude)) * sin(radians(45.6499975))
)) AS distanza
FROM parks
WHERE park_id = 5;



-- visualizzare tutti i dati di tutti i parchi
SELECT * 
FROM parks as p
INNER JOIN addresses as a 
ON p.park_id = a.park_id
INNER JOIN (
    SELECT park_id,
    (
      CASE WHEN pet_friendly THEN 1 ELSE 0 END + 
      CASE WHEN child_friendly THEN 1 ELSE 0 END +
      CASE WHEN drinkable_water THEN 1 ELSE 0 END +
      CASE WHEN bike THEN 1 ELSE 0 END +
      CASE WHEN car_parking THEN 1 ELSE 0 END +
      CASE WHEN wheelchair_accessible THEN 1 ELSE 0 END +
      CASE WHEN wheelchair_accessible_car_parking THEN 1 ELSE 0 END +
      CASE WHEN public_toilet THEN 1 ELSE 0 END +
      CASE WHEN picnic_table THEN 1 ELSE 0 END
    ) AS services_number
  FROM informations
) AS i
ON p.park_id = i.park_id
INNER JOIN (
    SELECT works_at, COUNT(*) AS staff_number
    FROM staff
    GROUP BY works_at
) AS s 
ON p.park_id = s.works_at
INNER JOIN (
    SELECT park_id, COUNT(*) AS reviews_number
    FROM reviews
    GROUP BY park_id
) AS r
ON p.park_id = r.park_id
-- se si vuole visualizzare solo i dati di un parco specifico
-- WHERE p.park_id = 1



-- visualizzare parchi con valutazione media superiore di un certo valore (Ex. 4)
SELECT *
FROM parks as p
INNER JOIN (
    SELECT park_id, AVG(mark) AS average_mark
    FROM reviews
    GROUP BY park_id
) as r
ON p.park_id = r.park_id
WHERE average_mark > 4