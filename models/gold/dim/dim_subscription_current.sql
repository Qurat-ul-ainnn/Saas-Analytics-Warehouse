{{ config(
    materialized='table',
    description='Current active subscription dimension derived from SCD2 snapshot'
) }}

with snapshot as (

    select * from {{ ref('subscription_snapshot') }}

)

select
    {{ dbt_utils.generate_surrogate_key(['subscription_id']) }} as subscription_sk,
    subscription_id,
    customer_id,
    plan,
    payment_type,
    trial_days,
    active,
    dbt_valid_from as effective_from
from snapshot
where dbt_valid_to is null