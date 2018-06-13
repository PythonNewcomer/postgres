create database studyDB;
create schema cinema;

create table cinema.genres(
	id serial primary key,
	genre varchar(255) not null unique
);

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

create table cinema.country(
	id serial primary key,
	name varchar(255) not null unique
);

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

create sequence if not exists next_movie_id;
	
create table cinema.movies(
	id int default nextval('next_movie_id') primary key,
	title varchar(255) not null unique,
	year_of_release int not null,
	length_in_minutes int not null,
	country_id int references cinema.country(id) not null,
	imdb_rating numeric (2, 1)  default  0.0,
	budget int not null,
	actors json
);

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

	
create table cinema.tv_shows(
	id int default nextval('next_movie_id') primary key,
	title varchar(255) not null unique,
	year_of_release int not null,
	length_in_minutes int not null,
	country_id int references cinema.country(id) not null,
	imdb_rating numeric (2, 1)  default  0.0,
	budget int not null
);
	
insert into cinema.tv_shows(title, year_of_release, length_in_minutes, country_id, imdb_rating, budget)
values
	('Band of Brothers', 2001, 594, 1, 9.5, 125000000),
	('Game of Thrones', 2011, 3300, 9, 9.5, 500000000),
	('Breaking Bad', 2008, 3030, 1, 9.5, 50000000);
	
create table cinema.genre_movie_show(
	id serial primary key,
	genre_id int references cinema.genres(id) not null,
	movie_show_id int not null
);

create or replace function cinema.return_movie_show_id(name varchar(255)) 
returns int 
as $$
declare
	inserted_id int;
begin
	inserted_id = (select id
				   from cinema.movies
				   where title = name
				   union
				   select id
				   from cinema.tv_shows
				   where title = name 
				   );
	return inserted_id;
end; 
$$
language plpgsql;

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


create or replace function cinema.insert_movie(movie varchar(255), year_ int, length_ int, country_id int,
									  rating numeric(2,1), budget int) 
returns int 
as $$
declare
	a_id int;
begin
	insert into cinema.movies(title, year_of_release, length_in_minutes, country_id, imdb_rating, budget)
	values(movie, year_, length_, country_id, rating, budget)
	returning id into a_id;
	return a_id;
end; 
$$
language plpgsql;

create table cinema.log_table(
	id serial primary key,
	log_date timestamp default current_timestamp(0),
	message varchar(255) not null
);

create or replace function cinema.update_log_table()
returns trigger as
$$
declare 
	message varchar(255);
begin
	if TG_OP = 'UPDATE' then
		message = 'Movie "' || new.title || '" was updated!';
	elsif TG_OP = 'INSERT' then
		message = 'New movie "' || new.title || '" was added!';
	elsif TG_OP = 'DELETE' then
		message = 'Movie "' || old.title || '" was deleted!';
	else
		message = 'Something weird has happened!';
	end if;

	insert into cinema.log_table(message)
	values(message);
	
	return new;
end; 
$$
language plpgsql;

create trigger new_movie_update
after update or insert or delete
on cinema.movies
for each row
	execute procedure cinema.update_log_table();


create extension if not exists "uuid-ossp";


create table cinema.user_activity(
	id uuid primary key,
	favourite_movie_id int not null,
	created_date timestamp default current_timestamp(0)
);

create or replace function cinema.return_random_movie_id() 
returns int 
as $$
declare
	a int;
	b int;
begin
	a = (select min(m.id) from cinema.movies m);
	b = (select max(m.id) from cinema.movies m);
	return (select floor(random() * b + a)::int);
end;
$$ 
language plpgsql strict;

create or replace function cinema.insert_random_record()
returns void 
as $$
declare
	id uuid;
	m_id int;
begin
	id = (select uuid_generate_v4());
	m_id = (select cinema.return_random_movie_id());
	insert into cinema.user_activity(id, favourite_movie_id)
	values(id, m_id);
end; 
$$
language plpgsql;

create table cinema.archive_user_activity(
	user_id uuid not null,
	favourite_movie_id int not null,
	created_date timestamp
);

update cinema.user_activity    ---------------to check whether CTE works in a proper way
set created_date = '2018-04-03 12:34:07'
where favourite_movie_id = 15;


with moved_rows as (    ------------------------------------------CTE which moves old data(more than 3 days) from cinema.user_activity to cinema.archive_user_activity
    delete from cinema.user_activity
    where
        cast(created_date as date) < current_date - int '3'
    returning *
)
insert into cinema.archive_user_activity (user_id, favourite_movie_id, created_date)
select * 
from moved_rows;


create or replace function cinema.loop_insert_random_record(n int)
	returns setof record 
	as $$
declare
	i record;
begin
	for i in 1..n loop
    perform cinema.insert_random_record();
	end loop;
	return;
end; 
$$
language plpgsql;

select cinema.loop_insert_random_record(1000); ---------------- this function inserts 1000 rows in cinema.user_activity


create view cinema.movie_and_genre as                   --------------- this view selects columns from 4 joined tables
select m.id, 
	title, 
	year_of_release, 
	c.name as country, 
	g.genre 
from cinema.movies m
inner join cinema.country c on m.country_id = c.id
inner join cinema.genre_movie_show gms on gms.movie_show_id= m.id
inner join cinema.genres g on gms.genre_id = g.id;


create materialized view cinema.country_movie
as
select c.name as country, count(m.id) as movie_amount
from cinema.country c
inner join cinema.movies m on m.country_id = c.id
group by country
order by movie_amount desc
with data;

create unique index country_movie_index on cinema.country_movie (country);

refresh materialized view concurrently cinema.country_movie;

----------------------------------------------------- SELECTS-----------------------------------------
select cinema.insert_movie('Dangal', 2016, 161, 8, 8.5, 10500000); -- function inserts new movie in the table "Cinems".Movie and returns this movie's ID;

insert into cinema.genre_movie_show(movie_show_id, genre_id) -- we insert movie and genres to which it belongs into table cinema.genre_movie_show;
values
	(cinema.return_movie_show_id('Dangal'),1),
	(cinema.return_movie_show_id('Dangal'),5),
	(cinema.return_movie_show_id('Dangal'),11);

select * 
from cinema.log_table; -- trigger reacted on insert command and logged changes into table cinema.log_table;


select g.genre, count(m.id) as amount          ------------ this select joins 3 tables to find genre and group movie's id by genre (with additional condition)
from cinema.movies m 
inner join cinema.genre_movie_show gms on m.id = gms.movie_show_id
inner join cinema.genres g on gms.genre_id = g.id
group by g.genre
having count(m.id) > 2;


