with source as (
    select * from {{ ref('raw_staff') }}
)
select
    staff_id,
    {{ clean_string('first_name') }} as first_name,
    {{ clean_string('last_name') }} as last_name,
    role,
    hire_date:: date as hire_date,
    termination_date:: date as termination_date,
    salary_rate
from source