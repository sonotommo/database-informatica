-- calcolo della distanza in chilometri da un parco definito (Ex park_id = 5) rispetto piazza unità o un punto dato
-- dati piazza unità: longitude: 13.7673139, latitude: 45.6499975
-- sostituire le coordinate con un qualsiasi punto dato per scoprirne la distanza in linea d'aria dal parco al punto prestabilito

SELECT
(6371 * acos(
    cos(radians(latitude)) * cos(radians(45.6499975)) * cos(radians(longitude) - radians(13.7673139)) + sin(radians(latitude)) * sin(radians(45.6499975))
)) AS distanza
FROM parks AS p
WHERE p.park_id = 5;



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



-- visualizzare i parchi che sono aperti tutto il giorno
SELECT *
FROM parks AS p
WHERE p.opening_time = '00:00' AND p.closing_time = '24:00'



-- visualizzare tutti i parchi che sono meno affollati in un dato giorno della settimana in un dato momento della giornata
-- (Ex. lunedì pomeriggio)
SELECT *
FROM parks AS p
INNER JOIN (
		SELECT park_id
		FROM crowded
		WHERE day = 'monday' AND afternoon = 'uncrowded'
) AS c
ON p.park_id = c.park_id



-- visualizzare i servizi presenti nei parchi
SELECT p.park_id, p.name, i.*
FROM parks AS p
INNER JOIN informations AS i
ON p.park_id = i.park_id
-- nel caso in cui si volesse un parco specifico
-- WHERE p.park_id = 1