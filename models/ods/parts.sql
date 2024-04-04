{{
  config({    
    "materialized": "table"
  })
}}

WITH parts AS (

  SELECT * 
  
  FROM {{ ref('base_part')}}

)

SELECT 
  p.part_key,
  p.part_name,
  p.part_manufacturer_name,
  p.part_brand_name,
  p.part_type_name,
  p.part_size,
  p.part_container_desc,
  p.retail_price

FROM parts AS p

ORDER BY p.part_key
