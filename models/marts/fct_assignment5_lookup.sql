{{ config(
    materialized='incremental',
    unique_key='title'
) }}

WITH base AS (
  SELECT
    title,
    DATE(datehour) AS date,
    COUNT(*) AS views
  FROM {{ source('test_dataset', 'assignment5_input') }}
  {% if is_incremental() %}
  WHERE DATE(datehour) >= (
    SELECT MAX(max_date) - 1 FROM {{ this }}
  )
  {% endif %}
  GROUP BY title, date
)

SELECT
  title,
  MIN(date) AS min_date,
  MAX(date) AS max_date,
  SUM(views) AS total_views
FROM base
GROUP BY title

