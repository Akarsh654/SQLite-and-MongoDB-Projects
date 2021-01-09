.print Question 6 - akrash
SELECT tag, COUNT(DISTINCT posts.pid), COUNT(vno) as num_votes
FROM tags, votes LEFT OUTER JOIN posts USING(pid)
WHERE tags.pid = votes.pid 
GROUP BY tag
ORDER BY num_votes DESC 
limit 3;


