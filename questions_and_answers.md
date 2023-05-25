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
FROM CovidDeaths
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
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY DATENAME(MONTH, date)
ORDER BY new_cases DESC;
````

**Results:**

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

#### What are the top ten countries that had the highest percentage infection rate compared to population?

````sql
SELECT TOP 10 location, population, MAX(total_cases) AS total_cases, ROUND(MAX((total_cases/population))*100,2) AS PercentPopulationInfected
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;
````

location	     |population|total_cases|PercentPopulationInfected|
--------------|----------|-----------|-------------------------|
Cyprus	       |    896007|     650685|                    72,62|
San Marino	   |     33690|      23616|                     70,1|
Austria	      |   8939617|    5943417|                    66,48|
Faeroe Islands|     53117|      34658|                   	65,25|
Slovenia	     |   2119843|    1330654|                    62,77|
Gibraltar	    |     32677|      20433|                    62,53|
Martinique	   |    367512|     229020|                    62,32|
Brunei	       |    449002|     279661|                    62,29|
Andorra	      |     79843|      47890|                    59,98|
Jersey	       |    110796|      66391|                    59,92|

#### What are the top ten countries that had the most covid deaths reported?

````sql
SELECT TOP 10 location, MAX(total_deaths) AS TotalDeathCount 
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;
````

**Results:**

location	     |TotalDeathCount|
--------------|---------------|
United States |        1111342|
Brazil        |         699276|
India         |	        530775|
Russia        |        	396378|
Mexico        |        	333100|
Peru          |	        219493|
United Kingdom|        	207695|
Italy         |	        188322|
Germany       |	        168583|
France        |	        161397|

#### What continent had the most death reported?

````sql
SELECT continent, MAX(total_deaths) AS TotalDeathCount 
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;
````

**Results:**

continent	   |TotalDeathCount|
-------------|---------------|
Europe       |	       2023354|
Asia	        |        1624789|
North America|        1585879|
South America|        1351340|
Africa       |         258757|
Oceania	     |          25338|



#### What is the probability of death from Covid in Poland?

````sql
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, ROUND(SUM(new_deaths)/SUM(new_cases)*100, 2) AS DeathPercentage
FROM CovidDeaths
WHERE location='Poland'
AND continent IS NOT NULL
ORDER BY 1, 2;
````

**Results:**

total_cases|total_deaths|DeathPercentage|
-----------|------------|---------------|
6437598	   |      118970|	          1,85|



#### How many total vaccinations were reported??

````sql
SELECT SUM(new_vaccinations) AS 'Total Reported Vaccinations'
FROM CovidVaccinations
WHERE continent IS NOT NULL
````

**Results:**

Total Reported Vaccinations|
---------------------------|
10847090480                |

#### What are the top ten countries that had the highest amount of vaccinations?

````sql
SELECT TOP 10 location, MAX(total_vaccinations) AS TotalVaccinations 
FROM CovidVaccinations
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalVaccinations DESC;
````

**Results:**

location     |TotalVaccinations|
-------------|-----------------|
China	       |       3491077000|
India	       |       2206401818|
United States|	       672076105|
Brazil	      |        485268593|
Indonesia    |	       444303130|
Japan        |	       382355682|
Bangladesh   |	       355143411|
Pakistan     |	       333759565|
Vietnam      |	       266252632|
Mexico       |	       223158993|

#### What are the top ten countries that had the highest percentage of vaccinated people compared to population?

````sql
SELECT TOP 10 location, population, MAX(people_vaccinated) AS people_vaccinated, ROUND(MAX((people_vaccinated/population))*100,2) AS PercentPopulationVaccinated
FROM CovidVaccinations
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationVaccinated DESC
````

**Results:**

location            |population|people_vaccinated|	PercentPopulationVaccinated|
--------------------|----------|-----------------|----------------------------|
Gibraltar           |     32677|	           42175|	                     129.07|
Tokelau             |	     1893|	            2203|	                     116.38|
United Arab Emirates|	  9441138|	         9991089|                     	105.83|
Qatar               |	  2695131|         	2851776|	                     105.81|
Nauru               |	    12691|           	13106|	                     103.27|
Brunei              |	   449002|	          450886|                     	100.42|
Pitcairn            |	       47|               47|	                        100|
Macao               |   	695180|	          679223|	                       97.7|
Cuba                |	 11212198|        	10728943|	                      95.69|
Portugal            |	 10270857|	         9780727|                      	95.23|

#### What month had the most tests conducted?

````sql
SELECT DATENAME(MONTH, date) AS 'Month', SUM(new_tests) AS 'Total tests'
FROM CovidVaccinations
WHERE continent IS NOT NULL
GROUP BY DATENAME(MONTH, date)
ORDER BY new_tests DESC;
````
**Results:**

Month	   |Total tests|
---------|-----------|
January  |  616514583|
December |  519532847|
February |  448604464|
March    |  444610066|
April    |  425868485|
November |  422251490|
October  |  401733631|
September|  390915318|
May	     |  379551504|
August   |  359184031|
June     |  343788020|
July	    |  320967491|

#### Which continent had the highest percentage of positive tests?

````sql
SELECT continent, ROUND(AVG(positive_rate), 2) AS AvgPositiveRate
FROM CovidVaccinations
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY AvgPositiveRate DESC;
````

**Results:**

continent    |AvgPositiveRate|
-------------|---------------|
South America|	          0,16|
North America|	          0,13|
Europe       |	           0,1|
Asia         |	          0,08|
Oceania      |	          0,08|
Africa       |	          0,07|          
