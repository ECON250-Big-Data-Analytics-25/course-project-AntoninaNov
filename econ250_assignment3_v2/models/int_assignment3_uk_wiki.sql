SELECT *,
  REGEXP_CONTAINS(title, r'^Вікіпедія:|^Файл:|^Категорія:|^Шаблон:|^Проєкт:|^Обговорення:|^Спеціальна:') AS is_meta_page,
  REGEXP_EXTRACT(title, r'^([^:]+):') AS meta_page_type
FROM {{ ref('stg_assignment3_uk_wiki') }}

