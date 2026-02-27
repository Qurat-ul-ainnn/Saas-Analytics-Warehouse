{{ config(materialized='table') }}

with source as (

    select
        customer_id,
        first_name,
        last_name,
        email,
        country,
        created_at
    from {{ source('bronze', 'customers') }}

),

cleaned as (

    select
        customer_id::int as customer_id,
        initcap(trim(first_name)) as first_name,
        initcap(trim(last_name)) as last_name,
        lower(trim(email)) as email,
        upper(trim(country)) as country,
        created_at::timestamp as created_at,
        date_trunc('month', created_at) as signup_month

    from source
    where customer_id is not null
      and email is not null

)

select * from cleaned