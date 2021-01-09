.print Question 2 - akrash
SELECT p.pid, title
FROM questions q, tags, posts p
WHERE p.pid = q.pid AND lower(title) LIKE lower("%relational database%")
UNION 
SELECT p.pid, title
FROM questions q, tags t1, tags t2, posts p
WHERE p.pid = q.pid AND lower(t1.tag) LIKE lower("%relational%") AND lower(t2.tag) LIKE lower("%database%")
AND t1.pid = t2.pid AND p.pid = t1.pid;