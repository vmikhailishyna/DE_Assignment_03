select
    attendance_id,
    duration_minutes
from {{ ref('stg_attendance') }}
where duration_minutes < 0