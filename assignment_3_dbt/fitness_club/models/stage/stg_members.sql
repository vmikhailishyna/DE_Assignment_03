with source as (
    select * from {{ ref('raw_members') }}
)
select
    member_id,
    {{ clean_string('full_name') }} as member_name,
    birth_date,
    registration_date:: date as registration_date
from source