{{ config(
    materialized='table',
    description='Churned subscriptions derived from SCD2 snapshot'
) }}

select
    subscription_id,
    customer_id,
    dbt_valid_to as churn_date
from {{ ref('subscription_snapshot') }}
where dbt_valid_to is not null