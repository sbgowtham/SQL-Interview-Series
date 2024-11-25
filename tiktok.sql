-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(255)
);

-- Videos Table
CREATE TABLE videos (
    video_id INT PRIMARY KEY,
    user_id INT,
    upload_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Interactions Table
CREATE TABLE interactions (
    interaction_id INT PRIMARY KEY,
    video_id INT,
    likes INT,
    comments INT,
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

-- Sample Data for Users
INSERT INTO users (user_id, username)
VALUES
(1, 'user_one'),
(2, 'user_two'),
(3, 'user_three');

-- Sample Data for Videos
INSERT INTO videos (video_id, user_id, upload_date)
VALUES
(101, 1, '2024-01-01'),
(102, 1, '2024-01-02'),
(103, 1, '2024-01-03'),
(104, 1, '2024-01-04'),
(105, 1, '2024-01-05'),
(201, 2, '2024-01-01'),
(202, 2, '2024-01-02'),
(203, 2, '2024-01-03'),
(301, 3, '2024-01-01');

-- Sample Data for Interactions
INSERT INTO interactions (interaction_id, video_id, likes, comments)
VALUES
(1001, 101, 150, 30),
(1002, 102, 80, 20),
(1003, 103, 200, 50),
(1004, 104, 120, 40),
(1005, 105, 50, 10),
(2001, 201, 300, 90),
(2002, 202, 100, 20),
(2003, 203, 20, 5),
(3001, 301, 10, 5);


Solution

-- Step 1: Identify videos with >100 interactions
WITH interactive_videos AS (
    SELECT 
        v.user_id,
        v.video_id,
        (i.likes + i.comments) AS total_interactions
    FROM 
        videos v
    JOIN 
        interactions i
    ON 
        v.video_id = i.video_id
    WHERE 
        (i.likes + i.comments) > 100
),

-- Step 2: Count interactive videos for each user
user_video_counts AS (
    SELECT 
        user_id,
        COUNT(video_id) AS interactive_video_count
    FROM 
        interactive_videos
    GROUP BY 
        user_id
),

-- Step 3: Filter users who have at least 5 total uploads and 3 highly interactive videos
highly_active_users AS (
    SELECT 
        u.user_id,
        u.interactive_video_count
    FROM 
        user_video_counts u
    JOIN 
        (SELECT user_id, COUNT(video_id) AS total_videos 
         FROM videos 
         GROUP BY user_id) v
    ON 
        u.user_id = v.user_id
    WHERE 
        v.total_videos >= 5 
        AND u.interactive_video_count >= 3
)

-- Final Output
SELECT 
    user_id,
    interactive_video_count 
FROM 
    highly_active_users
ORDER BY 
    interactive_video_count DESC;
