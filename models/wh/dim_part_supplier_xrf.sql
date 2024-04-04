{{
  config({    
    "materialized": "table"
  })
}}

WITH nations AS (

  SELECT * 
  
  FROM {{ ref('nations')}}

),

parts AS (

  SELECT * 
  
  FROM {{ ref('parts')}}

),

parts_suppliers AS (

  SELECT * 
  
  FROM {{ ref('parts_suppliers')}}

),

regions AS (

  SELECT * 
  
  FROM {{ ref('regions')}}

),

suppliers AS (

  SELECT * 
  
  FROM {{ ref('suppliers')}}

),

final AS (

  SELECT 
    ps.part_supplier_key,
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
    supplier_address,
    s.supplier_phone_number,
    s.supplier_account_balance,
    n.nation_key AS supplier_nation_key,
    n.nation_name AS supplier_nation_name,
    r.region_key AS supplier_region_key,
    r.region_name AS supplier_region_name,
    ps.supplier_availabe_quantity,
    ps.supplier_cost_amount
  
  FROM parts AS p
  JOIN parts_suppliers AS ps
     ON p.part_key = ps.part_key
  JOIN suppliers AS s
     ON ps.supplier_key = s.supplier_key
  JOIN nations AS n
     ON s.nation_key = n.nation_key
  JOIN regions AS r
     ON n.region_key = r.region_key

)

SELECT 
  f.*,
  {{ dbt_housekeeping() }}

FROM final AS f

ORDER BY f.part_key, f.supplier_key
