{{ config(
    materialized='table',
    description='Monthly revenue churn calculation'
) }}

with churned as (

    select
        date_trunc('month', churn_date) as churn_month,
        count(*) as churned_subscriptions
    from {{ ref('fct_churn') }}
    group by 1

)

select *
from churned
order by churn_month