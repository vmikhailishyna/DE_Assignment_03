{{ config(
    materialized='incremental',
    unique_key='member_id'
) }}

select
    member_id,
    member_name,
    registration_date,
    count(*) over (partition by member_id) as total_visits,
    max(registration_date) over () as last_system_update
from {{ ref('stg_members') }}

{% if is_incremental() %}
  where registration_date > (select max(registration_date) from {{ this }})
{% endif %}