


--Select the data that we are going to be using
 SELECT location, date, total_cases, new_cases, total_deaths, population 
 FROM coviddeaths;

 -- Looking at Total Cases vs Total Deaths
 --Shows likelihood of dying if you contrac covid in your country
SELECT location, date, total_cases, total_deaths, (Total_deaths/total_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE location='Poland'
AND continent IS NOT NULL
ORDER BY 1, 2;

--Looking at Total Cases vs Population
--Shows what percentage of population got Covid
SELECT location, date, total_cases, population, (Total_cases/population)*100 AS cases_percentage
FROM coviddeaths
WHERE location='Poland'
AND continent IS NOT NULL
ORDER BY 1, 2;

--Looking at Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;


--Showing countries with Highest Death per Population

SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount 
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


--LET'S BREAK THINGS DOWN BY CONTINENT


--Showing continents with the highest Death count per Population

SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount 
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

--GLOBAL NUMBERS

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE location='Poland'
AND continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- Looking at Total Population vs Vaccinations

-- USE CTE

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS 
(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM coviddeaths dea
INNER JOIN covidvaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL)
SELECT *, (RollingPeopleVaccinated/population)*100 AS RollingPeopleVaccinated
FROM PopvsVac

--TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    RolingPeopleVaccinated NUMERIC
)
INSERT INTO  #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM coviddeaths dea
INNER JOIN covidvaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL


-- Creating view to store data for later visualization

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM coviddeaths dea
INNER JOIN covidvaccinations vac
ON dea.location = vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL;

SELECT *
FROM PercentPopulationVaccinated;

