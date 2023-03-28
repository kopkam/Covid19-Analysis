# COVID-19 Deaths & Vaccinations 
## Questions and Answers

**Author**: Marcin Kopka

**Email**: marcin.kopka1337@gmail.com

**LinkedIn**: https://www.linkedin.com/in/marcin-kopka1/


#### How many total deaths were reported?

````sql
SELECT SUM(new_deaths) AS 'Total Reported Deaths'
FROM CovidDeaths
WHERE continent IS NOT NULL
````

**Results:**

Total Reported Deaths|
---------------------|
6869457|

 #### What are the top ten countries that had the most covid cases reported?

````sql
SELECT TOP 10 location, SUM(new_cases) AS total_cases
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_cases DESC
````

**Results:**

location      |total_cases  |
--------------|-------------|
United States	|    102247392|
China	        |     99109603|
India	        |     44689121|
France	       |     38538948|
Germany	      |     38221663|
Brazil	       |     37076626|
Japan	        |     33264491|
South Korea   |     30581499|
Italy	        |     25603510|
United Kingdom|     24396534|

#### What month had the most cases reported?

````sql
SELECT DATENAME(MONTH, date) AS 'Month', SUM(new_cases) AS new_cases
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY DATENAME(MONTH, date)
ORDER BY new_cases DESC;
````

Month    |Total Cases|
---------|-----------|
December |  134720080|
January  |  132502657|
February |   74845278|
March    |   66667546|
July     |   53389779|
August   |   52906732|
April	   |   49768179|
November |   44141195|
September|   39512621|
May	     |   39216931|
October	 |   38838304|
June	    |   32923564|

