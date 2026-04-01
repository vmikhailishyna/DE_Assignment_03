with source as (
    select * from {{ ref('raw_subscriptions') }}
)
select
    subscription_id,
    member_id,
    plan_id,
    start_date::date as start_date,
    end_date::date as end_date
from source