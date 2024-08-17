# Movie ratings analysis using R & SQL

#activate SQL
install.packages("RMySQL")
library(RMySQL)

#connect to our DB
?dbConnect
our.conn=dbConnect(MySQL(), user="user_4st604", password="pass_4st604",
                     dbname="db_4st604", host="db4free.net", port=3306)
our.conn

#find Moneyball movie ID
movies=dbGetQuery(our.conn,'SELECT * FROM movies;')
Moneyball_ID=dbGetQuery(our.conn,'SELECT movieId FROM movies WHERE title="Moneyball";')
Moneyball_ID

#then use movies-ratings table to extract all ratings for Moneyball movie
movies_ratings=dbGetQuery(our.conn,'SELECT * FROM movies_ratings;')

#what is the average rating for this movie?
Moneyball_avg_rating=dbGetQuery(our.conn,'SELECT AVG(rating) FROM movies_ratings WHERE movieId = 89492;')
Moneyball_avg_rating

#how many ratings are there
Moneyball_count_rating=dbGetQuery(our.conn,'SELECT COUNT(rating) FROM movies_ratings WHERE movieId = 89492;')
Moneyball_count_rating

#visualize the distribution of movie ratings
Moneyball_ratings <- dbGetQuery(our.conn, 'SELECT rating FROM movies_ratings WHERE movieId = 89492;')
Moneyball_ratings_df <- data.frame(rating = Moneyball_ratings$rating)
par(mfrow=c(1,1))
hist(Moneyball_ratings_df$rating,
     main="Distribution of Ratings for Moneyball Movie",
     xlab='Rating',col='darkgreen',xlim=c(3, 5),breaks=seq(0, 5, by=0.5))

#is this a good score? find out what is average,
movies_ratings_avg=dbGetQuery(our.conn,'SELECT AVG(rating) FROM movies_ratings')
movies_ratings_avg

#max,
movies_ratings_max=dbGetQuery(our.conn,'SELECT MAX(rating) FROM movies_ratings')
movies_ratings_max

#and min score on table movies_ratings
movies_ratings_min=dbGetQuery(our.conn,'SELECT MIN(rating) FROM movies_ratings')
movies_ratings_min

print('Results: Monetball movie has a rating above average, therefore its score is fairly good')

