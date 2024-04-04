{{
  config({    
    "materialized": "table"
  })
}}

WITH part_suppliers AS (

  SELECT * 
  
  FROM {{ ref('base_part_supplier')}}

),

parts AS (

  SELECT * 
  
  FROM {{ ref('parts')}}

),

suppliers AS (

  SELECT * 
  
  FROM {{ ref('suppliers')}}

)

SELECT 
  {{ dbt_tpch.surrogate_key('p.part_key', 's.supplier_key') }} AS part_supplier_key,
  p.part_key,
  p.part_name,
  p.part_manufacturer_name,
  p.part_brand_name,
  p.part_type_name,
  p.part_size,
  p.part_container_desc,
  p.retail_price,
  s.supplier_key,
  s.supplier_name,
  s.nation_key,
  ps.supplier_availabe_quantity,
  ps.supplier_cost_amount

FROM parts AS p
JOIN part_suppliers AS ps
   ON p.part_key = ps.part_key
JOIN suppliers AS s
   ON ps.supplier_key = s.supplier_key

ORDER BY p.part_key
