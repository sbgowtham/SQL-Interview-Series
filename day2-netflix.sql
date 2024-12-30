-- Problem - Write a solution to report the movies with an odd-numbered ID and a description that is not "boring". Return the result table ordered by rating in descending order.

Solution 
  
CREATE TABLE Cinema (
    id INT PRIMARY KEY,
    movie VARCHAR(255),
    description VARCHAR(255),
    rating FLOAT
);

INSERT INTO Cinema (id, movie, description, rating) VALUES
(1, 'The Dark Knight', 'thrilling', 9.0),
(2, 'The Hangover', 'boring', 7.7),  
(3, 'Inception', 'mind-bending', 8.8),
(4, 'Titanic', 'romantic', 7.8),
(5, 'Avengers: Endgame', 'epic action', 8.4),
(6, 'The Matrix', 'sci-fi action', 8.7),
(7, 'The Godfather', 'classic crime drama', 9.2),
(8, 'Cars', 'animated comedy', 6.8),
(9, 'The Lion King', 'boring', 8.5),  -- Boring movie
(10, 'Interstellar', 'epic space drama', 8.6);


select * from cinema
where
mod(id,2) = 1 and 
description != 'boring'
order by rating desc ;
