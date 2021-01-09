.print Question 7 - akrash
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



