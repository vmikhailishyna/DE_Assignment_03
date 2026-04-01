with source as (
    select * from {{ ref('raw_classes') }}
)
select
    class_id,
    {{ clean_string('class_name') }} as class_name,
    trainer_id,
    start_time,
    max_capacity
from source