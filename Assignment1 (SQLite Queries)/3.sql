.print Question 3 - akrash
SELECT q.pid, title
FROM posts p, questions q
WHERE p.pid = q.pid 
EXCEPT 
SELECT q.pid, p1.title
FROM questions q, posts p1, posts p2, answers a
WHERE p1.pid = q.pid AND p2.pid = a.pid AND a.qid = q.pid
AND julianday(p2.pdate) - julianday(p1.pdate) <= 3;



