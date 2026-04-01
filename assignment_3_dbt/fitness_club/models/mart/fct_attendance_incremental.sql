{{
    config(
        materialized='incremental',
        unique_key='attendance_id',
        incremental_strategy='delete+insert',
        incremental_predicates=["check_in_at > current_date - interval 7 day"]
    )
}}

select * from {{ ref('stg_attendance') }}
{% if is_incremental() %}
  where check_in_at > (select max(check_in_at) from {{ this }})
{% endif %}

