use ig_clone;


select * from comments;


select * from users;

select * from likes;

select * from `follows`;

select * from photo_tags;

select * from tags;

select * from photos;











SELECT id, username, created_at 
FROM users 
ORDER BY created_at ASC 
LIMIT 5;

SELECT u.id, u.username 
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
WHERE p.id IS NULL;

SELECT p.id AS photo_id, p.image_url, p.user_id, COUNT(l.user_id) AS like_count
FROM photos p
JOIN likes l ON p.id = l.photo_id
GROUP BY p.id, p.image_url, p.user_id
ORDER BY like_count DESC
LIMIT 1;

SELECT t.tag_name, COUNT(pt.photo_id) AS usage_count
FROM tags t
JOIN photo_tags pt ON t.id = pt.tag_id
GROUP BY t.id, t.tag_name
ORDER BY usage_count DESC
LIMIT 5;

SELECT DAYNAME(created_at) AS day_of_week, COUNT(*) AS user_count
FROM users
GROUP BY day_of_week
ORDER BY user_count DESC
LIMIT 1;

SELECT AVG(photo_count) AS avg_posts_per_user
FROM (
    SELECT u.id, COUNT(p.id) AS photo_count
    FROM users u
    LEFT JOIN photos p ON u.id = p.user_id
    GROUP BY u.id
) AS user_photo_counts;


SELECT u.id, u.username
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM photos p
    WHERE NOT EXISTS (
        SELECT 1
        FROM likes l
        WHERE l.user_id = u.id AND l.photo_id = p.id
    )
);







