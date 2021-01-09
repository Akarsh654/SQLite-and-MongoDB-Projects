.print Question 8 - akrash
SELECT u.uid, ifnull(qns, 0), ifnull(ans, 0), ifnull(vcast, 0), ifnull(vrec, 0)
FROM  users u LEFT OUTER JOIN (SELECT poster, COUNT(*) as qns
				FROM posts p, questions q
				WHERE p.pid = q.pid
				GROUP BY poster) AS t1 ON t1.poster = u.uid 

LEFT OUTER JOIN (SELECT poster, COUNT(*) as ans
FROM posts p, answers a 
WHERE p.pid = a.pid
GROUP BY poster) AS t2 ON t2.poster = u.uid 

LEFT OUTER JOIN (SELECT u.uid, COUNT(*) as vcast
FROM users u, votes v
WHERE v.uid = u.uid
GROUP BY u.uid) AS t3 ON t3.uid = u.uid 

LEFT OUTER JOIN (SELECT poster, COUNT(*) AS vrec
FROM posts p, votes v, users u
WHERE v.pid = p.pid AND u.uid = p.poster 
GROUP BY poster) AS t4 ON t4.poster = u.uid 

GROUP BY u.uid

HAVING qns >= 1 OR ans >= 1 OR vcast >= 1 OR vrec >= 1;





