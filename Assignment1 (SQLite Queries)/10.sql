.print Question 10 - akrash
SELECT u.city, ifnull(numUsers,0), ifnull(numGB, 0), ifnull(AVG(qnsCnt)/numUsers,0), ifnull(vrec,0) 

FROM users u LEFT OUTER JOIN (SELECT city, COUNT(*) as numUsers
			     FROM users u
			     GROUP BY city)tu USING(city)

LEFT OUTER JOIN (SELECT city, COUNT(*) as qnsCnt
      FROM questionInfo qi, users u
      WHERE qi.uid = u.uid
      GROUP BY city)tq USING(city)

LEFT OUTER JOIN (SELECT city, COUNT(*) as numGB
      FROM questionInfo qi, ubadges ub, badges b, users u
      WHERE u.uid = qi.uid AND b.type = 'gold' AND u.uid = ub.uid AND b.bname = ub.bname
      GROUP BY city)t2 USING(city)

LEFT OUTER JOIN (SELECT city, COUNT(*) AS vrec
	FROM posts p, votes v, users u
	WHERE v.pid = p.pid AND u.uid = p.poster 
	GROUP BY city) USING(city)

GROUP BY u.city;
