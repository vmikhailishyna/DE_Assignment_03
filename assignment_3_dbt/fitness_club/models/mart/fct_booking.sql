{{ config(
    materialized='incremental',
    unique_key='booking_id'
) }}

select * from {{ ref('stg_bookings') }}
{% if is_incremental() %}
  where created_at > (select max(created_at) from {{ this }})
{% endif %}