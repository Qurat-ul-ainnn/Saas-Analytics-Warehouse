{{ config(
    materialized='table',
    description='Cohort retention analysis by signup month and activity month'
) }}

with customers as (

    select
        customer_id,
        date_trunc('month', created_at) as cohort_month
    from {{ ref('dim_customers') }}

),

activity as (

    select
        customer_id,
        date_trunc('month', invoice_date) as activity_month
    from {{ ref('fct_invoices') }}

),

joined as (

    select
        c.cohort_month,
        a.activity_month,
        count(distinct a.customer_id) as active_customers
    from customers c
    join activity a
      on c.customer_id = a.customer_id
    group by 1,2

)

select *
from joined
order by cohort_month, activity_month