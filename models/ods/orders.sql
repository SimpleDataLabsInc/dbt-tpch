{{
  config({    
    "materialized": "table"
  })
}}

WITH orders AS (

  SELECT * 
  
  FROM {{ ref('base_orders')}}

)

SELECT 
  o.order_key,
  o.order_date,
  o.customer_key,
  o.order_status_code,
  o.order_priority_code,
  o.order_clerk_name,
  o.shipping_priority,
  o.order_amount

FROM orders AS o

ORDER BY o.order_date
