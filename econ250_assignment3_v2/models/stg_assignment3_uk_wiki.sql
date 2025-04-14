WITH desktop AS (
  SELECT 
    title, 
    datehour,
    'desktop' AS src
  FROM {{ source('test_dataset', 'assignment3_input_uk') }}
),
mobile AS (
  SELECT 
    title, 
    datehour,
    'mobile' AS src
  FROM {{ source('test_dataset', 'assignment3_input_uk_m') }}
)

SELECT 
  title,
  datehour,
  src,
  DATE(datehour) AS date,
  EXTRACT(DAYOFWEEK FROM datehour) AS day_of_week,
  EXTRACT(HOUR FROM datehour) AS hour_of_day
FROM (
  SELECT * FROM desktop
  UNION ALL
  SELECT * FROM mobile
)

