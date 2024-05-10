{{
  config({    
    "materialized": "table"
  })
}}

WITH orders_items AS (

  SELECT * 
  
  FROM {{ ref('orders_items')}}

),

parts_suppliers AS (

  SELECT * 
  
  FROM {{ ref('parts_suppliers')}}

),

final AS (

  SELECT 
    o.order_item_key,
    o.order_key,
    o.order_date,
    o.customer_key,
    o.order_status_code,
    o.part_key,
    o.supplier_key,
    o.return_status_code,
    o.order_line_number,
    o.order_line_status_code,
    o.ship_date,
    o.commit_date,
    o.receipt_date,
    o.ship_mode_name,
    ps.supplier_cost_amount,
    {#ps.retail_price,#}
    o.base_price,
    o.discount_percentage,
    o.discounted_price,
    o.tax_rate,
    1 AS order_item_count,
    o.quantity,
    o.gross_item_sales_amount,
    o.discounted_item_sales_amount,
    o.item_discount_amount,
    o.item_tax_amount,
    o.net_item_sales_amount
  
  FROM orders_items AS o
  JOIN parts_suppliers AS ps
     ON o.part_key = ps.part_key and o.supplier_key = ps.supplier_key

)

SELECT 
  f.*,
  {{ dbt_housekeeping() }}

FROM final AS f

ORDER BY f.order_date
