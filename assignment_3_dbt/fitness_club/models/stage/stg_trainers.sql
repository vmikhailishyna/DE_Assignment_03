with source as (
    select * from {{ ref('raw_trainers') }}
)
select
    trainer_id,
    {{ clean_string('full_name') }} as full_name,
    {{ clean_string('specialization') }} as specialization,
    hourly_rate,
    hire_date:: date as hire_date,
    termination_date::date as termination_date,
    {{ format_phone('phone') }} as phone
from source