{{ config(
    materialized='table',
    description='Annual recurring revenue derived from MRR'
) }}

select
    revenue_month,
    total_revenue * 12 as arr
from {{ ref('fct_mrr_monthly') }}