#activate the package (tell R, that we are going to work with this package)
library(RMySQL)
#create connection
?dbConnect
our.conn = dbConnect(MySQL(), user="user_4st604", password="pass_4st604",
                     dbname="db_4st604", host="db4free.net", port=3306)
our.conn #you can see that con is connection object to the database
dbListTables(our.conn)

#HOMEWORK: task 5
#INNER JOIN
dbGetQuery(our.conn,"
           SELECT *
           FROM movies
           INNER JOIN movies_ratings 
           ON movies.movieId =  movies_ratings.movieId
           LIMIT 5
           ;") #I limited the number of rows for convenience
#LEFT JOIN
dbGetQuery(our.conn,"
           SELECT *
           FROM movies
           LEFT JOIN movies_ratings 
           ON movies.movieId =  movies_ratings.movieId
           LIMIT 5
           ;")
#LEFT JOIN
dbGetQuery(our.conn,"
           SELECT *
           FROM movies
           LEFT JOIN movies_ratings 
           ON movies.movieId =  movies_ratings.movieId
           LIMIT 5
           ;")
#FULL JOIN
dbGetQuery(our.conn,"
           SELECT * 
           FROM movies 
           FULL OUTER JOIN movies_ratings 
           ON movies.movieId =  movies_ratings.movieId
           LIMIT 5
           ;")
#ERROR! THis syntax is not supported. We will use LEFT JOIN + UNION + RIGHT JOIN 
dbGetQuery(our.conn,"
           SELECT *
           FROM movies
           LEFT JOIN movies_ratings ON movies.movieId = movies_ratings.movieId
           UNION
           SELECT *
           FROM movies
           RIGHT JOIN movies_ratings ON movies.movieId = movies_ratings.movieId
           LIMIT 5
           ;")
#Let's filter the results to find how many ratings for the movie Braveheart:
dbGetQuery(our.conn,"
           SELECT COUNT(movies_ratings.rating) AS ratings_count
           FROM movies
           INNER JOIN movies_ratings 
           ON movies.movieId = movies_ratings.movieId
           WHERE movies.title = 'Braveheart';
           ;") #answer = 139