with source as (
    select * from {{ ref('raw_attendance') }}
)
select
    attendance_id,
    member_id,
    attendance_timestamp:: timestamp as check_in_at,
    exit_timestamp::timestamp as check_out_at,
    date_diff('minute', check_in_at, check_out_at) as duration_minutes
from source