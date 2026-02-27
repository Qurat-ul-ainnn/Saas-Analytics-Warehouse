{{ config(
    materialized='table',
    description='Customer lifetime value calculated from total invoice revenue'
) }}

select
    customer_id,
    sum(revenue) as lifetime_revenue
from {{ ref('fct_invoices') }}
group by customer_id