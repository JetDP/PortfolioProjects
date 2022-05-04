select *
From Projects..movies$
order by 3,4

--1.
select name,year,released,gross,genre,rating,runtime,budget
from projects..movies$
order by year, released
--Yearly grossings
select mov.year, sum((gross*Inflation_Multiplier2022)) as Grossings2022
From Projects..movies$ mov
join Projects..IRmultiplier$ IR
	on mov.year = IR.year
group by mov.year
order by Grossings2022 DESC

--2.
--Showing what genre of movies gross the highest
--Accounts for inflation

select genre, sum(gross * Inflation_Multiplier2022) as TotalGenreGross2022, count(genre) as #ofMovies
from Projects..movies$ mov
join Projects..IRmultiplier$ IR
	on mov.year = IR.year
where gross is not null
group by genre
order by TotalGenreGross2022 DESC

--3.
--Showing what genre of movies gross the highest average
--Accounts for inflation

select genre, AVG(gross * Inflation_Multiplier2022) as AvgGenreGross2022, count(genre) as #ofMovies
from Projects..movies$ mov
join Projects..IRmultiplier$ IR
	on mov.year = IR.year
where gross is not null
group by genre
order by AvgGenreGross2022 DESC

--4.
--Show highest grossing movie with account for inflation
select name, mov.year, (gross * Inflation_Multiplier2022) as Gross2022
From Projects..movies$ mov
join Projects..IRmultiplier$ IR
	on mov.year = IR.year
order by Gross2022 DESC

--5.
--Looking at Gross vs Budget (Profit)
--What movies have the best profit
--Inflation accounted for
select name,mov.year,released,((gross-budget)*Inflation_Multiplier2022) as Profit2022
From Projects..movies$ mov
join Projects..IRmultiplier$ IR
	on mov.year = IR.year
where gross is not null and budget is not null
order by Profit2022 DESC

--6.
--Showing years where Movies had the highest profit
--Some movies are not shown due to not knowing budget or Grossing of movie
--Does account for inflation
select mov.year, sum(((gross-budget)*Inflation_Multiplier2022)) as Profit2022
From Projects..movies$ mov
join Projects..IRmultiplier$ IR
	on mov.year = IR.year
group by mov.year
order by Profit2022 DESC

--Number of movies each year by genre
select genre,count(genre) as #ofmovies, year
from Projects..movies$
group by year,genre
order by year