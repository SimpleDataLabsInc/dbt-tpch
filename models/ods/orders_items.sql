{{
  config({    
    "materialized": "table"
  })
}}

WITH line_items AS (

  SELECT * 
  
  FROM {{ ref('base_line_item')}}

),

orders AS (

  SELECT * 
  
  FROM {{ ref('base_orders')}}

)

SELECT 
  {{ dbt_tpch.surrogate_key('o.order_key', 'l.order_line_number') }} AS order_item_key,
  o.order_key,
  o.order_date,
  o.customer_key,
  o.order_status_code,
  l.part_key,
  l.supplier_key,
  l.return_status_code,
  l.order_line_number,
  l.order_line_status_code,
  l.ship_date,
  l.commit_date,
  l.receipt_date,
  l.ship_mode_name,
  l.quantity,
    (l.extended_price/nullif(l.quantity, 0)){{ money() }} as base_price,
    l.discount_percentage,
    (base_price * (1 - l.discount_percentage)){{ money() }} as discounted_price,

    l.extended_price as gross_item_sales_amount,
    (l.extended_price * (1 - l.discount_percentage)){{ money() }} as discounted_item_sales_amount,
    -- We model discounts as negative amounts
    (-1 * l.extended_price * l.discount_percentage){{ money() }} as item_discount_amount,
    l.tax_rate,
    ((gross_item_sales_amount + item_discount_amount) * l.tax_rate){{ money() }} as item_tax_amount,
    (
        gross_item_sales_amount + 
        item_discount_amount + 
        item_tax_amount
    ){{ money() }} as net_item_sales_amount

FROM orders AS o
JOIN line_items AS l
   ON o.order_key = l.order_key

ORDER BY o.order_date
