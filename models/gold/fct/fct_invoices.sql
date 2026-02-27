{{ config(
    materialized='incremental',
    unique_key='invoice_id',
    cluster_by=['invoice_date'],
    description='Invoice fact table with incremental loading'
) }}

select
    invoice_id,
    customer_id,
    invoice_date,
    final_amount as revenue,
    currency
from {{ ref('stg_invoices') }}

{% if is_incremental() %}
where invoice_date > (select max(invoice_date) from {{ this }})
{% endif %}