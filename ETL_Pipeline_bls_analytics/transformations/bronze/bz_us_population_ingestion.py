

from pyspark import pipelines as dp
from pyspark.sql import functions as F



BASE_DIR = "/Volumes/pr_population_volume/default/raw/data"

@dp.table(
    name="pr_population_volume.bronze.bz_us_population",
    comment="Raw data from US Population - API call data being loaded using Auto loader",
    table_properties={
        "delta.columnMapping.mode": "name",
        "delta.minReaderVersion": "2",
        "delta.minWriterVersion": "5",
    },
)
def bz_us_population():
    return (
        spark.readStream.format("cloudFiles")
        .option("cloudFiles.format", "json")
        .option("cloudFiles.inferColumnTypes", "true")
        .load(f"{BASE_DIR}/us_population")
        .withColumn("_ingested_at", F.current_timestamp())      # When the record was ingested
        .withColumn("_ingested_by", F.current_user())           # Who (service principal / user) ran the pipeline
        .withColumn("_source_file", F.col("_metadata.file_path")) # Source file path from Auto Loader metadata
        .withColumn("_source_file_tms", F.col("_metadata.file_modification_time"))
    )
    

