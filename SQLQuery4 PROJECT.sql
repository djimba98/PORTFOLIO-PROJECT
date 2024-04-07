
Select * from CovidDeath
where continent is not null
order by 3,4
--select the Data that I am going to use

Select location, date, total_cases, new_cases, total_deaths, population
from CovidDeath
order by 1,2


-- Locating at total cases vs total deaths
-- Shows likelyhood of dying after contracting Covid19 in the Uk

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeath
where location='United Kingdom'
order by 1,2


-- Extracting Total cases vs Population
-- Shows Percentage of population that contracted Covid19 in the UK
Select location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
from CovidDeath
where location='United Kingdom'
order by 1,2

-- Countries with the highest infection rate comprated to population

select location, population, max(total_cases) as Highestinfectioncount, max((total_cases/population))*100 as Percentagepopulationinfected
from CovidDeath
group by location, population
order by Percentagepopulationinfected desc

-- Showing countries with highest deaths count per population
select location, population, max(cast(total_deaths as int)) as TotalDeathcount, max((total_deaths/population))*100 as PercentagepopulationDeath
from CovidDeath
where continent is not null
group by location, population
order by TotalDeathcount desc

-- Total deaths by continent

select location, max(cast(total_deaths as int)) as TotalDeathcount
from CovidDeath
where continent is null
group by location
order by TotalDeathcount desc

-- Location with highest death count
select location, max(cast(total_deaths as int)) as Totaldeathscount
from CovidDeath
group by location
order by Totaldeathscount desc

-- Count of global numbers
select sum(new_cases) as totalcases, sum(cast(new_deaths as int)) as totaldeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Percentaheglobaldeath
from CovidDeath
where continent is not null
order by 1,2

-- UK and US total cases comparison
SELECT
    (SELECT SUM(total_cases) FROM CovidDeath WHERE location = 'United Kingdom') AS UKTotalcase,
    (SELECT SUM(total_cases) FROM CovidDeath WHERE location = 'United States') AS USTotalcases;

-- JOINS
select * from CovidDeath
join CovidVaccination
on CovidDeath.location=CovidVaccination.location
and CovidDeath.date=CovidVaccination.date

-- Total population vs Vaccinations
select CovidDeath.continent, CovidDeath.location, CovidDeath.date, CovidDeath.population, CovidVaccination.new_vaccinations, sum(cast(coviddeath.new_vaccinations as int)) over (partition by coviddeath.location)
from CovidDeath
join CovidVaccination
on CovidDeath.location=CovidVaccination.location
and CovidDeath.date=CovidVaccination.date
where CovidDeath.continent is not null
order by CovidDeath.population desc










select sum(population) as totalpopulation, sum(total_vaccinations)
