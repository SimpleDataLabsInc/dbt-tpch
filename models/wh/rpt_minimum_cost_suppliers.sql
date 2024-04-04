{{
  config({    
    "materialized": "table"
  })
}}

WITH dim_part_supplier_xrf AS (

  SELECT * 
  
  FROM {{ ref('dim_part_supplier_xrf')}}

),

parts_suppliers AS (

  SELECT 
    s.supplier_account_balance,
    s.supplier_name,
    s.supplier_nation_key,
    s.supplier_region_key,
    s.supplier_nation_name,
    s.supplier_region_name,
    s.part_key,
    s.part_manufacturer_name,
    s.part_size,
    s.part_type_name,
    s.supplier_cost_amount,
    s.supplier_address,
    s.supplier_phone_number,
    rank() OVER (PARTITION BY s.supplier_region_key, s.part_key ORDER BY s.supplier_cost_amount) AS supplier_cost_rank,
    row_number() OVER (PARTITION BY s.supplier_region_key, s.part_key, s.supplier_cost_amount ORDER BY s.supplier_account_balance DESC) AS supplier_rank
  
  FROM dim_part_supplier_xrf AS s

)

SELECT s.*

FROM parts_suppliers AS s

WHERE s.supplier_cost_rank = 1 and s.supplier_rank <= 100

ORDER BY s.supplier_name, s.part_key
