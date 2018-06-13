insert into cinema.genres(genre)
values
	('Action'),
	('Adventure'),
	('Comedy'),
	('Crime'), 
	('Drama'), 
	('Historical'), 
	('Horror'), 
	('Sci-fi'), 
	('War'),
	('Western'),
	('Biography'),
	('Fantasy'),
	('Thriller');
	
insert into cinema.country(name)
values
	('USA'),
	('Italy'),
	('France'),
	('Japan'),
	('Brazil'),
	('Germany'),
	('South Korea'),
	('India'),
	('UK');
	
insert into cinema.movies(title, year_of_release, length_in_minutes, country_id, imdb_rating, budget)
values
	('The Shawshank Redemption', 1994, 142, 1, 9.3, 25000000),
	('The Godfather', 1972, 175, 1, 9.2, 6000000),
	('The Godfather: Part II', 1974, 202, 1, 9.0, 13000000),
	('The Dark Knight', 2008, 152, 1, 9.0, 185000000),
	('12 Angry Men', 1957, 96, 1, 8.9, 350000),
	('Schindler''s List', 1993, 195, 1, 8.9, 22000000),
	('The Lord of the Rings: The Return of the King', 2003, 201, 1, 8.9, 94000000),
	('Pulp Fiction', 1994, 154, 1, 8.9,8000000),
	('Seven Samurai', 1954, 207, 4, 8.8, 2000000),
	('Goodfellas', 1990, 146, 1, 8.7, 25000000),
	('City of God', 2002, 130, 5, 8.6, 3300000),
	('Se7en', 1995, 127, 1, 8.6, 33000000),
	('The Intouchables', 2011, 112, 3, 8.5, 10000000),
	('Cinema Paradiso', 1988, 155, 2, 8.5, 5000000),
	('The Lives of Others', 2006, 137, 6, 8.4,2000000),
	('Oldeuboi', 2003, 120, 7, 8.4, 3000000);
	
insert into cinema.tv_shows(title, year_of_release, length_in_minutes, country_id, imdb_rating, budget)
values
	('Band of Brothers', 2001, 594, 1, 9.5, 125000000),
	('Game of Thrones', 2011, 3300, 9, 9.5, 500000000),
	('Breaking Bad', 2008, 3030, 1, 9.5, 50000000);
	
insert into cinema.genre_movie_show(movie_show_id, genre_id)
values
	(cinema.return_movie_show_id('The Shawshank Redemption'),4),
	(cinema.return_movie_show_id('The Shawshank Redemption'),5),
	(cinema.return_movie_show_id('The Godfather'),4),
	(cinema.return_movie_show_id('The Godfather'),5),
	(cinema.return_movie_show_id('The Godfather: Part II'),4),
	(cinema.return_movie_show_id('The Godfather: Part II'),5),
	(cinema.return_movie_show_id('The Dark Knight'),4),
	(cinema.return_movie_show_id('The Dark Knight'),5),
	(cinema.return_movie_show_id('The Dark Knight'),1),
	(cinema.return_movie_show_id('12 Angry Men'),4),
	(cinema.return_movie_show_id('12 Angry Men'),5),
	(cinema.return_movie_show_id('Schindler''s List'),5),
	(cinema.return_movie_show_id('Schindler''s List'),6),
	(cinema.return_movie_show_id('Schindler''s List'),11),
	(cinema.return_movie_show_id('The Lord of the Rings: The Return of the King'),2),
	(cinema.return_movie_show_id('The Lord of the Rings: The Return of the King'),5),
	(cinema.return_movie_show_id('The Lord of the Rings: The Return of the King'),12),
	(cinema.return_movie_show_id('Pulp Fiction'),4),
	(cinema.return_movie_show_id('Pulp Fiction'),5),
	(cinema.return_movie_show_id('Seven Samurai'),2),
	(cinema.return_movie_show_id('Seven Samurai'),5),
	(cinema.return_movie_show_id('Goodfellas'),5),
	(cinema.return_movie_show_id('Goodfellas'),4),
	(cinema.return_movie_show_id('Goodfellas'),11),
	(cinema.return_movie_show_id('City of God'),4),
	(cinema.return_movie_show_id('City of God'),5),
	(cinema.return_movie_show_id('Se7en'),4),
	(cinema.return_movie_show_id('Se7en'),5),
	(cinema.return_movie_show_id('Se7en'),13),
	(cinema.return_movie_show_id('The Intouchables'),11),
	(cinema.return_movie_show_id('The Intouchables'),3),
	(cinema.return_movie_show_id('The Intouchables'),5),
	(cinema.return_movie_show_id('Cinema Paradiso'),5),
	(cinema.return_movie_show_id('The Lives of Others'),13),
	(cinema.return_movie_show_id('Oldeuboi'),5),
	(cinema.return_movie_show_id('Oldeuboi'),1),
	(cinema.return_movie_show_id('Oldeuboi'),13),
	(cinema.return_movie_show_id('Band of Brothers'),1),
	(cinema.return_movie_show_id('Band of Brothers'),5),
	(cinema.return_movie_show_id('Band of Brothers'),6),
	(cinema.return_movie_show_id('Game of Thrones'),1),
	(cinema.return_movie_show_id('Game of Thrones'),2),
	(cinema.return_movie_show_id('Game of Thrones'),5),
	(cinema.return_movie_show_id('Breaking Bad'),4),
	(cinema.return_movie_show_id('Breaking Bad'),5),
	(cinema.return_movie_show_id('Breaking Bad'),13);
	
with moved_rows as (                 -- CTE which moves old data(more than 3 days) from cinema.user_activity to cinema.archive_user_activity
    delete from cinema.user_activity
    where
        cast(created_date as date) < current_date - int '3'
    returning *
)
insert into cinema.archive_user_activity (user_id, favourite_movie_id, created_date)
select * 
from moved_rows;
	
update cinema.user_activity    -- to check whether CTE works in a proper way
set created_date = '2018-04-03 12:34:07'
where favourite_movie_id = 15;

select cinema.insert_movie('Dangal', 2016, 161, 8, 8.5, 10500000); -- function inserts new movie in the table cinema.movies and returns this movie's id;

select * 
from cinema.log_table; -- to check whether trigger reacts on insert command and logs changes into table cinema.log_table

insert into cinema.genre_movie_show(movie_show_id, genre_id) -- insert movie and genres to which it belongs into table cinema.genre_movie_show;
values
	(cinema.return_movie_show_id('Dangal'),1),
	(cinema.return_movie_show_id('Dangal'),5),
	(cinema.return_movie_show_id('Dangal'),11);
