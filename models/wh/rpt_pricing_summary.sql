{{
  config({    
    "materialized": "table"
  })
}}

WITH fct_orders_items AS (

  SELECT * 
  
  FROM {{ ref('fct_orders_items')}}

)

/*
Per TPC-H Spec:
2.4.1 Pricing Summary Report Query (Q1)
*/
SELECT 
  f.return_status_code,
  f.order_line_status_code,
  sum(f.quantity) AS quantity,
  sum(f.gross_item_sales_amount) AS gross_item_sales_amount,
  sum(f.discounted_item_sales_amount) AS discounted_item_sales_amount,
  sum(f.net_item_sales_amount) AS net_item_sales_amount,
  avg(f.quantity) AS avg_quantity,
  avg(f.base_price) AS avg_base_price,
  avg(f.discount_percentage) AS avg_discount_percentage,
  sum(f.order_item_count) AS order_item_count

FROM fct_orders_items AS f

WHERE f.ship_date <= {{ dbt_tpch.dateadd('day', -90,  var('max_ship_date')) }}

GROUP BY 
  1, 2
