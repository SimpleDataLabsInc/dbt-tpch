{{
  config({    
    "materialized": "ephemeral"
  })
}}

SELECT 
  ps_partkey AS part_key,
  ps_suppkey AS supplier_key,
  ps_availqty AS supplier_availabe_quantity,
  ps_supplycost{{ money() }} AS supplier_cost_amount,
  ps_comment AS part_supplier_comment

FROM {{ source('tpch', 'partsupp') }}
