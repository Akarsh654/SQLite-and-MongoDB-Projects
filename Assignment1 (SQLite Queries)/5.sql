.print Question 5 - akrash
SELECT poster
FROM posts p, questions q
WHERE p.pid = q.pid 
INTERSECT 
SELECT poster
FROM posts p, answers a
WHERE p.pid = a.pid 
INTERSECT
SELECT poster
FROM posts p, votes v
WHERE p.pid = v.pid 
GROUP BY poster
HAVING COUNT(*) > 4;
