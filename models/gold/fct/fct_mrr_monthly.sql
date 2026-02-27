{{ config(
    materialized='table',
    description='Monthly recurring revenue aggregated by month'
) }}

with monthly as (

    select
        date_trunc('month', invoice_date) as revenue_month,
        sum(revenue) as total_revenue
    from {{ ref('fct_invoices') }}
    group by 1

)

select *
from monthly
order by revenue_month