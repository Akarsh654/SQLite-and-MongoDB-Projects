.print Question 1 - akrash
SELECT u.uid
FROM users u, questions q, posts p
WHERE p.pid = q.pid AND u.uid = p.poster
INTERSECT 
SELECT u.uid
FROM badges b, ubadges u
WHERE b.bname = u.bname AND type = "gold";
