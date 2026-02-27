{{ config(materialized='table') }}

with source as (

    select
        subscription_id,
        customer_id,
        plan,
        start_date,
        payment_type,
        trial_days,
        active,
        promo_code
    from {{ source('bronze', 'subscriptions') }}

),

cleaned as (

    select
        subscription_id::int as subscription_id,
        customer_id::int as customer_id,

        case
            when lower(plan) like '%basic%' then 'basic'
            when lower(plan) like '%pro%' then 'pro'
            when lower(plan) like '%enterprise%' then 'enterprise'
            else 'unknown'
        end as plan,

        start_date::date as start_date,
        payment_type,
        trial_days::int as trial_days,

        case 
            when active = 1 then true
            when active = 0 then false
            else null
        end as active,

        promo_code,

        case 
            when active = 1 then 'active'
            when active = 0 then 'churned'
            else 'unknown'
        end as subscription_status,

        date_trunc('month', start_date) as subscription_start_month

    from source
    where subscription_id is not null

)

select * from cleaned