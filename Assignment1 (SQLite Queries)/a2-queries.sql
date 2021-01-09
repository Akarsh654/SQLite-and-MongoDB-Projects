.echo on

--Question 1
SELECT u.uid
FROM users u, questions q, posts p
WHERE p.pid = q.pid AND u.uid = p.poster
INTERSECT 
SELECT u.uid
FROM badges b, ubadges u
WHERE b.bname = u.bname AND type = "gold";

--Question 2
SELECT p.pid, title
FROM questions q, tags, posts p
WHERE p.pid = q.pid AND lower(title) LIKE lower("%relational database%")
UNION 
SELECT p.pid, title
FROM questions q, tags t1, tags t2, posts p
WHERE p.pid = q.pid AND lower(t1.tag) LIKE lower("%relational%") AND lower(t2.tag) LIKE lower("%database%")
AND t1.pid = t2.pid AND p.pid = t1.pid;

--Question 3
SELECT q.pid, title
FROM posts p, questions q
WHERE p.pid = q.pid 
EXCEPT 
SELECT q.pid, p1.title
FROM questions q, posts p1, posts p2, answers a
WHERE p1.pid = q.pid AND p2.pid = a.pid AND a.qid = q.pid
AND julianday(p2.pdate) - julianday(p1.pdate) <= 3;

--Question 4
SELECT poster
FROM posts p, questions q, answers a
WHERE p.pid = q.pid AND q.pid = a.qid
GROUP BY poster
HAVING COUNT(*) > 3;

--Question 5
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

--Question 6
SELECT tag, COUNT(DISTINCT posts.pid), COUNT(vno) as num_votes
FROM tags, votes LEFT OUTER JOIN posts USING(pid)
WHERE tags.pid = votes.pid 
GROUP BY tag
ORDER BY num_votes DESC 
limit 3;

--Question 7
SELECT p.pdate, t.tag, MAX(num)
FROM (posts p LEFT OUTER JOIN (SELECT pdate, tag, COUNT(tag) as num
	FROM tags t, posts p
	WHERE t.pid = p.pid
	GROUP BY tag, pdate)t1 USING(pdate)), tags t
WHERE t.pid = p.pid 
GROUP BY p.pdate, t.tag
INTERSECT
SELECT pdate, tag, num
FROM (SELECT pdate, tag, COUNT(tag) as num
	FROM tags t, posts p
	WHERE t.pid = p.pid
	GROUP BY pdate, tag)	 
GROUP BY pdate, tag;

--Question 8
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

--Question 9
CREATE VIEW questionInfo(pid, uid, theaid, voteCnt, ansCnt)

AS SELECT q.pid, poster, ifnull(q.theaid, 'null'), ifnull(voteCnt, 0), ifnull(ansCnt, 0)
FROM posts p, answers a,
 
questions q LEFT OUTER JOIN (
SELECT q2.pid, COUNT(vno) as voteCnt
FROM posts p, questions q2, votes v
WHERE p.pid = q2.pid AND v.pid = q2.pid  
GROUP BY q2.pid)t1 USING(pid),

questions q3 LEFT OUTER JOIN (
SELECT q.pid, COUNT(a.pid) as ansCnt
FROM questions q, posts p, answers a
WHERE p.pid = q.pid AND a.qid = q.pid
GROUP BY q.pid)t2 USING(pid)

WHERE p.pid = q.pid AND q.pid = q3.pid AND 
julianday('now','start of month','+1 month','-1 day') - julianday(pdate) < 63

GROUP BY q.pid, poster;

--Question 10
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









