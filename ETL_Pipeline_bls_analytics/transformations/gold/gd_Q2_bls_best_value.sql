USE CATALOG pr_population_volume;

CREATE OR REFRESH MATERIALIZED VIEW gold.gd_best_year_per_series AS
SELECT
    series_id,
    year,
    total_value
FROM (
    SELECT
        series_id,
        year,
        SUM(value) AS total_value,
        ROW_NUMBER() OVER (
            PARTITION BY series_id
            ORDER BY SUM(value) DESC
        ) AS rn
    FROM silver.sv_bls_pr
    GROUP BY series_id, year
)
WHERE rn = 1;