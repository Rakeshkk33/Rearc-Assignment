USE CATALOG pr_population_volume;

CREATE OR REFRESH MATERIALIZED VIEW gold.gd_q3_bls_pr
SELECT
  bls.series_id as Series_ID,
  bls.year  as Year,  
  sum(bls.value) as Total_Value,  
  coalesce(us_pop.Population,0) as Population 
FROM
  silver.sv_bls_pr as bls
  left join
   silver.sv_us_population_flattened as us_pop
on bls.Year=us_pop.Year
where 
bls.period in ('Q01','Q02','Q03','Q04') 
 and 
bls.series_id='PRS30006032'
group by    
  bls.series_id,
  bls.year,    
  us_pop.Population
  order by Year

