# COVID-19 Deaths & Vaccinations 
## Questions and Answers

**Author**: Marcin Kopka

**Email**: marcin.kopka1337@gmail.com

**LinkedIn**: https://www.linkedin.com/in/marcin-kopka1/


#### How many total deaths were reported?

````sql
SELECT SUM(total_deaths) AS "Total Reported Deaths"
FROM CovidDeaths
WHERE continent IS NOT NULL
````

**Results:**

Total Reported Deaths|
---------------------|
4402422914|

