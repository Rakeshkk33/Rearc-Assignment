USE CATALOG pr_population_volume;

CREATE OR REFRESH STREAMING TABLE silver.sv_bls_pr;

APPLY CHANGES INTO silver.sv_bls_pr
FROM STREAM silver.sv_bls_pr_temp
KEYS (series_id, year,period,value,footnote_codes)
SEQUENCE BY processed_tms;   