
select * from Total
select * from Urban
select * from Rural
select * from Renewable
select * from Oil
select * from Nuclear
select * from Losses


---Working with the Metadata
select * from Metadata

--Deleting Columns of Metadata
ALTER TABLE Metadata
DROP COLUMN column6, SpecialNotes;
--Renaming columns of Metadata
EXEC sp_rename 'Metadata.TableName', 'Country Name', 'COLUMN';


---- Joining Metadata and Data file to Combine Region and Incomegroup in the table:

select A.*, B.Region, B.IncomeGroup from Rural A Inner Join Metadata B ON A.Country_Code=B.Country_Code


select * into rural_merge from (select A.*, B.Region, B.IncomeGroup from Rural A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;

select * into urban_merge from (select A.*, B.Region, B.IncomeGroup from Urban A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;

select * into total_merge from (select A.*, B.Region, B.IncomeGroup from Total A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;

select * into oil_merge from (select A.*, B.Region, B.IncomeGroup from Oil A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;

select * into renewable_merge from (select A.*, B.Region, B.IncomeGroup from Renewable A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;

select * into nuclear_merge from (select A.*, B.Region, B.IncomeGroup from Nuclear A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;

select * into losses_merge from (select A.*, B.Region, B.IncomeGroup from Losses A Inner Join Metadata B ON A.Country_Code=B.Country_Code
)A;





--- Reading the merged table

select * from rural_merge;
select * from urban_merge;
select * from total_merge;
select * from oil_merge;
select * from renewable_merge;
select * from nuclear_merge;
select * from losses_merge;



---◦ Comparison of access to electricity post 2000s in different countries
SELECT COUNTRY_NAME, AVG(isnull(_2001,0) + isnull(_2002,0) + isnull(_2003,0) + isnull(_2004,0) + isnull(_2005,0)
	+ isnull(_2006,0) + isnull(_2007,0) + isnull(_2008,0) + isnull(_2009,0) + isnull(_2010,0)
	+ isnull(_2011,0) + isnull(_2012,0) + isnull(_2013,0) + isnull(_2014,0) + isnull(_2015,0)
	+ isnull(_2016,0) + isnull(_2017,0) + isnull(_2018,0) + isnull(_2019,0))  AS AVERAGE_OF_ELECTRICITY_IN_POST_2000S
FROM total_merge
group by Country_Name;

---OR



select s1.Country_Name , n/d as Avg_2000s_Total  from (
	select  Country_Name, sum(
	 isnull(_2001,0) + isnull(_2002,0) + isnull(_2003,0) + isnull(_2004,0) + isnull(_2005,0)
	+ isnull(_2006,0) + isnull(_2007,0) + isnull(_2008,0) + isnull(_2009,0) + isnull(_2010,0)
	+ isnull(_2011,0) + isnull(_2012,0) + isnull(_2013,0) + isnull(_2014,0) + isnull(_2015,0)
	+ isnull(_2016,0) + isnull(_2017,0) + isnull(_2018,0) + isnull(_2019,0)) as n ,
	(count(_2001) + count(_2002) + count(_2003)+ count(_2004) 
	+ count(_2005) + count(_2006) + count(_2007) + count(_2008) + count(_2009) + count(_2010)+ count(_2011) 
	+ count(_2012) + count(_2013) + count(_2014) + count(_2015) + count(_2016) + count(_2017)+ count(_2018) 
	+ count(_2019)) as d 
	from total_merge where Region is not null
	group by Country_Name
	) as s1 
	where s1.d != 0 order by Avg_2000s_Total desc

	select * from renewable_merge



---◦ Find one interesting insight present in the data (across all the tables) 



with CTE AS(
(select '01' AS SR_NO,'60s' as Years,ROUND(AVG(N._60s),2) AS 'Nuclear',ROUND(AVG(O._60s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '02' AS SR_NO,'70s' as Years,ROUND(AVG(N._70s),2) AS 'Nuclear',ROUND(AVG(O._70s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '03' AS SR_NO,'80s' as Years,ROUND(AVG(N._80s),2) AS 'Nuclear',ROUND(AVG(O._80s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '04' AS SR_NO,'90s' as Years,ROUND(AVG(N._90s),2) AS 'Nuclear',ROUND(AVG(O._90s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '05' AS SR_NO,'2000s' as Years,ROUND(AVG(N._2000s),2) AS 'Nuclear',ROUND(AVG(O._2010s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '06' AS SR_NO,'2010' as Years,ROUND(AVG(N._2010),2) AS 'Nuclear',ROUND(AVG(O._2010),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '07' AS SR_NO,'2011' as Years,ROUND(AVG(N._2011),2) AS 'Nuclear',ROUND(AVG(O._2011),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '08' AS SR_NO,'2012' as Years,ROUND(AVG(N._2012),2) AS 'Nuclear',ROUND(AVG(O._2012),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '09' AS SR_NO,'2013' as Years,ROUND(AVG(N._2013),2) AS 'Nuclear',ROUND(AVG(O._2013),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '10' AS SR_NO,'2014' as Years,ROUND(AVG(N._2014),2) AS 'Nuclear',ROUND(AVG(O._2014),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '11' AS SR_NO,'2015' as Years,ROUND(AVG(N._2015),2) AS 'Nuclear',ROUND(AVG(O._2015),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
)

SELECT *,(100-Nuclear-Oil) AS Others FROM CTE



--- Present a way to compare every country’s performance with respect to world
---average for every year. As in, if someone wants to check how is the
---accessibility of electricity in India in 2006 as compared to average access of
---the world to electricity

with cte as(
(select '2000' as Years,Country_Name,round(_2000,2) as Percentages from total)
union
(select '2001' as years,Country_Name,round(_2001,2) as percentages from total)
union
(select '2002' as years,Country_Name,round(_2002,2) as percentages from total)
union
(select '2003' as years,Country_Name,round(_2003,2) as percentages from total)
union
(select '2004' as years,Country_Name,round(_2004,2) as percentages from total)
union
(select '2005' as years,Country_Name,round(_2005,2) as percentages from total)
union
(select '2006' as years,Country_Name,round(_2006,2) as percentages from total)
union
(select '2007' as years,Country_Name,round(_2007,2) as percentages from total)
union
(select '2008' as years,Country_Name,round(_2008,2) as percentages from total)
union
(select '2009' as years,Country_Name,round(_2009,2) as percentages from total)
union
(select '2010' as years,Country_Name,round(_2010,2) as percentages from total)
union
(select '2011' as years,Country_Name,round(_2011,2) as percentages from total)
union
(select '2012' as years,Country_Name,round(_2012,2) as percentages from total)
union
(select '2013' as years,Country_Name,round(_2013,2) as percentages from total)
union
(select '2014' as years,Country_Name,round(_2014,2) as percentages from total)
union
(select '2015' as Years,Country_Name,round(_2015,2) as Percentages from total)
union
(select '2016' as years,Country_Name,round(_2016,2) as percentages from total)
union
(select '2017' as years,Country_Name,round(_2017,2) as percentages from total)
union
(select '2018' as years,Country_Name,round(_2018,2) as percentages from total)
union
(select '2019' as years,Country_Name,round(_2019,2) as percentages from total)
union
(select '2020' as years,Country_Name,round(_2020,2) as percentages from total)
), 


cte2 as (select *,avg(percentages) over(partition by years) as average from cte)

select Years,Country_Name,Percentages,round(average ,2) Annual_Averages from cte2

---Can write country name here
where Country_Name='India'




---A chart to depict the increase in count of country with greater than 75%
---electricity access in rural areas across different year. For example, what was
---the count of countries having ≥75% rural electricity access in 2000 as
---compared to 2010.
select * from Rural

select Top 1 (select count(*) from rural where _2000> 75)as "_2000" , (select count(*) from rural where _2001> 75) as "_2001" ,( select count(*) from rural where _2002> 75) as "_2002"
,( select count(*) from rural where _2003> 75) as "_2003",( select count(*) from rural where _2004> 75) as "_2004",( select count(*) from rural where _2005> 75) as "_2005"
,( select count(*) from rural where _2006> 75) as "_2006",( select count(*) from rural where _2007> 75) as "_2007",( select count(*) from rural where _2008> 75) as "_2008"
,( select count(*) from rural where _2009> 75) as "_2009",( select count(*) from rural where _2010> 75) as "_2010",( select count(*) from rural where _2011> 75) as "_2011"
,( select count(*) from rural where _2012> 75) as "_2012",( select count(*) from rural where _2013> 75) as "_2013",( select count(*) from rural where _2014> 75) as "_2014"
,( select count(*) from rural where _2015> 75) as "_2015" ,(select count(*)  from rural where _2016> 75) as "_2016", (select count(*) from rural where _2017> 75) as "_2017"
, (select count(*)  from rural where _2018> 75) as "_2018", (select count(*) from rural where _2019> 75) as "_2019"
, (select count(*)  from rural where _2020> 75) as "_2020" from rural

--Total 266 Countries




---Define a way/KPI to present the evolution of nuclear power presence
---grouped by Region and IncomeGroup . How was the nuclear power
---generation in the region of Europe & Central Asia as compared to SubSaharan Africa. 
select s1.Region ,s1.IncomeGroup ,  n/d  as Nuclear_Production from (
	select  Region,IncomeGroup , sum(isnull(_2000,0)
	+ isnull(_2001,0) + isnull(_2002,0) + isnull(_2003,0) + isnull(_2004,0) + isnull(_2005,0)
	+ isnull(_2006,0) + isnull(_2007,0) + isnull(_2008,0) + isnull(_2009,0) + isnull(_2010,0)
	+ isnull(_2011,0) + isnull(_2012,0) + isnull(_2013,0) + isnull(_2014,0) + isnull(_2015,0)
	) as n ,
	(count(_2000) + count(_2001) + count(_2002) + count(_2003)+ count(_2004) 
	+ count(_2005) + count(_2006) + count(_2007) + count(_2008) + count(_2009) + count(_2010)+ count(_2011) 
	+ count(_2012) + count(_2013) + count(_2014) + count(_2015))
	as d
	from nuclear_merge
	group by  Region,IncomeGroup
	) as s1

	---can put the country here in commented section of where
	where s1.d != 0 and s1.Region is not null and s1.IncomeGroup is not null /*and Region in ('Europe & Central Asia','Sub-Saharan Africa')*/ order by Region


---Distinct Regions
	select Distinct Region from nuclear_merge



--- A chart to present the production of electricity across different sources
---(nuclear, oil, etc.) as a function of time

with CTE AS(
(select '01' AS SR_NO,'60s' as Years,ROUND(AVG(N._60s),2) AS 'Nuclear',ROUND(AVG(O._60s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '02' AS SR_NO,'70s' as Years,ROUND(AVG(N._70s),2) AS 'Nuclear',ROUND(AVG(O._70s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '03' AS SR_NO,'80s' as Years,ROUND(AVG(N._80s),2) AS 'Nuclear',ROUND(AVG(O._80s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '04' AS SR_NO,'90s' as Years,ROUND(AVG(N._90s),2) AS 'Nuclear',ROUND(AVG(O._90s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '05' AS SR_NO,'2000s' as Years,ROUND(AVG(N._2000s),2) AS 'Nuclear',ROUND(AVG(O._2010s),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '06' AS SR_NO,'2010' as Years,ROUND(AVG(N._2010),2) AS 'Nuclear',ROUND(AVG(O._2010),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '07' AS SR_NO,'2011' as Years,ROUND(AVG(N._2011),2) AS 'Nuclear',ROUND(AVG(O._2011),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '08' AS SR_NO,'2012' as Years,ROUND(AVG(N._2012),2) AS 'Nuclear',ROUND(AVG(O._2012),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '09' AS SR_NO,'2013' as Years,ROUND(AVG(N._2013),2) AS 'Nuclear',ROUND(AVG(O._2013),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '10' AS SR_NO,'2014' as Years,ROUND(AVG(N._2014),2) AS 'Nuclear',ROUND(AVG(O._2014),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
UNION
(select '11' AS SR_NO,'2015' as Years,ROUND(AVG(N._2015),2) AS 'Nuclear',ROUND(AVG(O._2015),2) AS 'Oil' from Nuclear n join oil o on o.Country_Name=n.Country_Name)
)

SELECT *,(100-Nuclear-Oil) AS Others FROM CTE