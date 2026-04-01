with source as (
    select * from {{ ref('raw_bookings') }}
)
select
    booking_id,
    member_id,
    trainer_id,
    booking_date::date as created_at,
    training_date::date as scheduled_for_date,
    training_time as scheduled_time
from source