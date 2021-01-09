.print Question 9 - akrash
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


