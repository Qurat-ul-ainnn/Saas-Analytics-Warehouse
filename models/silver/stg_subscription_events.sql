with source as (

    select * from {{ source('bronze','subscription_events') }}

),

cleaned as (

    select
        event_id::int as event_id,
        subscription_id::int as subscription_id,
        lower(trim(event_type)) as event_type,
        event_date::date as event_date

    from source
    where event_id is not null
      and subscription_id is not null
      and event_type is not null

),

validated as (

    select *
    from cleaned
    where event_type in ('upgrade', 'downgrade', 'cancel')

)

select * from validated