{{
  config({    
    "materialized": "ephemeral"
  })
}}

SELECT 
  p_partkey AS part_key,
  p_name AS part_name,
  p_mfgr AS part_manufacturer_name,
  p_brand AS part_brand_name,
  p_type AS part_type_name,
  p_size AS part_size,
  p_container AS part_container_desc,
  p_retailprice AS retail_price,
  p_comment AS part_comment

FROM {{ source('tpch', 'part') }}
