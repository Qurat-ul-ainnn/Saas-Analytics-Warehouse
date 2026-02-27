{{ config(materialized='table') }}

with source as (

    select
        invoice_id,
        customer_id,
        invoice_date,
        amount,
        discount,
        final_amount,
        currency
    from {{ source('bronze', 'invoices') }}

),

cleaned as (

    select
        invoice_id::int as invoice_id,
        customer_id::int as customer_id,
        invoice_date::date as invoice_date,
        amount::number(10,2) as amount,
        coalesce(discount, 0)::number(10,2) as discount,
        final_amount::number(10,2) as final_amount,
        upper(trim(currency)) as currency,
        date_trunc('month', invoice_date) as invoice_month

    from source
    where final_amount >= 0
      and invoice_date <= current_date

)

select * from cleaned