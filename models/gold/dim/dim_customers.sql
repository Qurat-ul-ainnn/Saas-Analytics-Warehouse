select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
    customer_id,
    first_name,
    last_name,
    email,
    country,
    signup_month,
    created_at,
    datediff('day', created_at, current_date) as customer_tenure_days,
    
    case
        when datediff('day', created_at, current_date) < 30 then 'New'
        when datediff('day', created_at, current_date) between 30 and 365 then 'Active'
        else 'Loyal'
    end as segment

from {{ ref('stg_customers') }}