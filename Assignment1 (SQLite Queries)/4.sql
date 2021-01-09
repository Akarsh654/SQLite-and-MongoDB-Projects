.print Question 4 - akrash
SELECT poster
FROM posts p, questions q, answers a
WHERE p.pid = q.pid AND q.pid = a.qid
GROUP BY poster
HAVING COUNT(*) > 3;


			

			


