with source as (
        select * from {{ source('bronze', 'subscriptions') }}
  ),
  renamed as (
      select
          {{ adapter.quote("SUBSCRIPTION_ID") }},
        {{ adapter.quote("CUSTOMER_ID") }},
        {{ adapter.quote("PLAN") }},
        {{ adapter.quote("START_DATE") }},
        {{ adapter.quote("PAYMENT_TYPE") }},
        {{ adapter.quote("TRIAL_DAYS") }},
        {{ adapter.quote("ACTIVE") }},
        {{ adapter.quote("PROMO_CODE") }}

      from source
  )
  select * from renamed
    