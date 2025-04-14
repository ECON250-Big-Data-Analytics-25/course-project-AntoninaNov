{{ config(materialized='table') }}

WITH base AS (
  SELECT 
    title,
    src,
    COUNT(*) AS views
  FROM {{ ref('int_assignment3_uk_wiki') }}
  WHERE NOT is_meta_page
  GROUP BY title, src
),
aggregated AS (
  SELECT 
    title,
    SUM(views) AS total_views,
    SUM(CASE WHEN src = 'mobile' THEN views ELSE 0 END) AS total_mobile_views
  FROM base
  GROUP BY title
)

SELECT *,
  ROUND((total_mobile_views / total_views) * 100, 2) AS mobile_percentage
FROM aggregated
ORDER BY mobile_percentage ASC
LIMIT 200

