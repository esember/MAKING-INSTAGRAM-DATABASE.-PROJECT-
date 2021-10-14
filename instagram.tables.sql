CODE: IG Clone Users Schema
1.	CREATE TABLE users (
2.	    id INTEGER AUTO_INCREMENT PRIMARY KEY,
3.	    username VARCHAR(255) UNIQUE NOT NULL,
4.	    created_at TIMESTAMP DEFAULT NOW()
5.	);
CODE: IG Clone Photos Schema
1.	CREATE TABLE photos (
2.	    id INTEGER AUTO_INCREMENT PRIMARY KEY,
3.	    image_url VARCHAR(255) NOT NULL,
4.	    user_id INTEGER NOT NULL,
5.	    created_at TIMESTAMP DEFAULT NOW(),
6.	    FOREIGN KEY(user_id) REFERENCES users(id)
7.	);
CODE: IG Clone Comments Schema
1.	CREATE TABLE comments (
2.	    id INTEGER AUTO_INCREMENT PRIMARY KEY,
3.	    comment_text VARCHAR(255) NOT NULL,
4.	    photo_id INTEGER NOT NULL,
5.	    user_id INTEGER NOT NULL,
6.	    created_at TIMESTAMP DEFAULT NOW(),
7.	    FOREIGN KEY(photo_id) REFERENCES photos(id),
8.	    FOREIGN KEY(user_id) REFERENCES users(id)
9.	);
CODE: IG Clone Likes Schema
1.	CREATE TABLE likes (
2.	    user_id INTEGER NOT NULL,
3.	    photo_id INTEGER NOT NULL,
4.	    created_at TIMESTAMP DEFAULT NOW(),
5.	    FOREIGN KEY(user_id) REFERENCES users(id),
6.	    FOREIGN KEY(photo_id) REFERENCES photos(id),
7.	    PRIMARY KEY(user_id, photo_id)
8.	);
CODE: IG Clone Followers Schema
1.	CREATE TABLE follows (
2.	    follower_id INTEGER NOT NULL,
3.	    followee_id INTEGER NOT NULL,
4.	    created_at TIMESTAMP DEFAULT NOW(),
5.	    FOREIGN KEY(follower_id) REFERENCES users(id),
6.	    FOREIGN KEY(followee_id) REFERENCES users(id),
7.	    PRIMARY KEY(follower_id, followee_id)
8.	);
CODE: IG Clone Photos Schema
1.	CREATE TABLE photos (
2.	    id INTEGER AUTO_INCREMENT PRIMARY KEY,
3.	    image_url VARCHAR(255) NOT NULL,
4.	    user_id INTEGER NOT NULL,
5.	    created_at TIMESTAMP DEFAULT NOW(),
6.	    FOREIGN KEY(user_id) REFERENCES users(id)
7.	);
CODE: IG Clone Comments Schema
1.	CREATE TABLE comments (
2.	    id INTEGER AUTO_INCREMENT PRIMARY KEY,
3.	    comment_text VARCHAR(255) NOT NULL,
4.	    photo_id INTEGER NOT NULL,
5.	    user_id INTEGER NOT NULL,
6.	    created_at TIMESTAMP DEFAULT NOW(),
7.	    FOREIGN KEY(photo_id) REFERENCES photos(id),
8.	    FOREIGN KEY(user_id) REFERENCES users(id)
9.	);
CODE: IG Clone Likes Schema
1.	CREATE TABLE likes (
2.	    user_id INTEGER NOT NULL,
3.	    photo_id INTEGER NOT NULL,
4.	    created_at TIMESTAMP DEFAULT NOW(),
5.	    FOREIGN KEY(user_id) REFERENCES users(id),
6.	    FOREIGN KEY(photo_id) REFERENCES photos(id),
7.	    PRIMARY KEY(user_id, photo_id)
8.	);
CODE: IG Clone Followers Schema
1.	CREATE TABLE follows (
2.	    follower_id INTEGER NOT NULL,
3.	    followee_id INTEGER NOT NULL,
4.	    created_at TIMESTAMP DEFAULT NOW(),
5.	    FOREIGN KEY(follower_id) REFERENCES users(id),
6.	    FOREIGN KEY(followee_id) REFERENCES users(id),
7.	    PRIMARY KEY(follower_id, followee_id)
8.	);
CODE: IG Clone Hashtags Schema
1.	CREATE TABLE tags (
2.	  id INTEGER AUTO_INCREMENT PRIMARY KEY,
3.	  tag_name VARCHAR(255) UNIQUE,
4.	  created_at TIMESTAMP DEFAULT NOW()
5.	);
6.	CREATE TABLE photo_tags (
7.	    photo_id INTEGER NOT NULL,
8.	    tag_id INTEGER NOT NULL,
9.	    FOREIGN KEY(photo_id) REFERENCES photos(id),
10.	    FOREIGN KEY(tag_id) REFERENCES tags(id),
11.	    PRIMARY KEY(photo_id, tag_id)
12.	);





Instagram Challenge 1 
-- 1. Finding 5 oldest users
1.	SELECT * 
2.	FROM users
3.	ORDER BY created_at
4.	LIMIT 5;



Instagram Challenge 2 
-- 2. Most Popular Registration Date



1.	SELECT 
2.	    DAYNAME(created_at) AS day,
3.	    COUNT(*) AS total
4.	FROM users
5.	GROUP BY day
6.	ORDER BY total DESC
7.	LIMIT 2;


Instagram Challenge 3
-- 3. Identify Inactive Users (users with no photos)


1.	SELECT username
2.	FROM users
3.	LEFT JOIN photos
4.	    ON users.id = photos.user_id
5.	WHERE photos.id IS NULL;


Instagram Challenge 4 
-- 4. Identify most popular photo (and user who created it)

1.	SELECT 
2.	    username,
3.	    photos.id,
4.	    photos.image_url, 
5.	    COUNT(*) AS total
6.	FROM photos
7.	INNER JOIN likes
8.	    ON likes.photo_id = photos.id
9.	INNER JOIN users
10.	    ON photos.user_id = users.id
11.	GROUP BY photos.id
12.	ORDER BY total DESC
13.	LIMIT 1;


Instagram Challenge 5 
-- 5. Calculate average number of photos per user


1.	SELECT (SELECT Count(*) 
2.	        FROM   photos) / (SELECT Count(*) 
3.	                          FROM   users) AS avg; 

Instagram Challenge 6 Solution CODE
-- 6. Find the five most popular hashtags
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 


Instagram Challenge 7 Solution CODE
-- 7. Finding the bots - the users who have liked every single photo

1.	SELECT username, 
2.	       Count(*) AS num_likes 
3.	FROM   users 
4.	       INNER JOIN likes 
5.	               ON users.id = likes.user_id 
6.	GROUP  BY likes.user_id 
7.	HAVING num_likes = (SELECT Count(*) 
8.	                    FROM   photos); 
