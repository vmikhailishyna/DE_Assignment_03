with source as (
    select * from {{ ref('raw_payments') }}
)
select
    payment_id,
    member_id,
    plan_id,
    amount,
    payment_date:: date as payment_date,
    payment_method
from source