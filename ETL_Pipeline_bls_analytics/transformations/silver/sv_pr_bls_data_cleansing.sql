USE CATALOG pr_population_volume;

CREATE OR REFRESH STREAMING TABLE silver.sv_bls_pr_temp
  COMMENT 'Silver dlt table ingestion of bronze bls pr data by standardizing the data types, record dedup and null value handeling'
SELECT
      trim(series_id)   as series_id,
      cast(year as INT) as Year,
      trim(period) as period,
      cast(value as decimal(5,2)) as value,
      coalesce(footnote_codes, "-") as footnote_codes,
      current_timestamp() as processed_tms      
from STREAM
      bronze.bz_bls_pr;

       

  