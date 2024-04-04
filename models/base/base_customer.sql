{{
  config({    
    "materialized": "ephemeral"
  })
}}

SELECT 
  c_custkey AS customer_key,
  c_name AS customer_name,
  c_address AS customer_address,
  c_nationkey AS nation_key,
  c_phone AS customer_phone_number,
  c_acctbal{{ money() }} AS customer_account_balance,
  c_mktsegment AS customer_market_segment_name,
  c_comment AS customer_comment

FROM {{ source('tpch', 'customer') }}
