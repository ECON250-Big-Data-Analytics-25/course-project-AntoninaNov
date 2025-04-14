WITH hourly AS (
  SELECT 
    datehour,
    EXTRACT(HOUR FROM datehour) AS hour_of_day,
    src,
    title
  FROM {{ ref('int_assignment3_uk_wiki') }}
  WHERE title = 'МКХ-10:_Клас_V._Розлади_психіки_та_поведінки'
)

SELECT
  hour_of_day,
  COUNT(*) AS total_views,
  COUNTIF(src = 'mobile') AS total_mobile_views
FROM hourly
GROUP BY hour_of_day
ORDER BY hour_of_day

