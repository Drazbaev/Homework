 --task 1
      
	SELECT gender,
	COUNT(*) AS amount
    FROM likes,profiles
    where  likes.user_id = profiles.user_id
    GROUP BY gender
    ORDER BY amount DESC
    LIMIT 1;

   
   
   SELECT 
  CONCAT(u.first_name, ' ', u.last_name) user,
  COUNT(m.from_user_id)  total_messages,
  COUNT(p.user_id) posts,  
  COUNT(md.user_id) media, 
  COUNT(l.user_id)   likes
	  FROM users u,  messages m, posts p, media md, likes l
	  WHERE m.from_user_id = u.id
	  and p.user_id = u.id
	  and  md.user_id = u.id
	  and l.user_id = u.id
group by CONCAT(u.first_name, ' ', u.last_name);