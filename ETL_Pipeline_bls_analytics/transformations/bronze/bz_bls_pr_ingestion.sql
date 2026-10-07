



USE CATALOG pr_population_volume;
USE SCHEMA bronze;

CREATE OR REFRESH STREAMING TABLE bz_bls_pr
COMMENT 'Bronze ingestion of BLS PR files by using Auto Loader'
AS SELECT
    *,    
    _metadata.file_path AS source_file_nm,
    _metadata.file_modification_time AS file_modified_tms,
    current_timestamp() AS tranformed_tms
FROM STREAM read_files(
    '/Volumes/pr_population_volume/default/raw/data/pr_data/pr.data.*',
    header => true,
    format => 'csv',
    sep => '\t',
    inferSchema => false,          
    schema => 'series_id STRING, year STRING, period STRING, value STRING, footnote_codes STRING'
);