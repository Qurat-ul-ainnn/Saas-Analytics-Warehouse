{% snapshot subscription_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='subscription_id',
        strategy='check',
        check_cols=['plan', 'active']
    )
}}

select *
from {{ ref('stg_subscriptions') }}

{% endsnapshot %}