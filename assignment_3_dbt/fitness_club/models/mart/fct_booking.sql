{{ config(
    materialized='incremental',
    unique_key='booking_id',
    incremental_strategy='delete+insert'
) }}

select * from {{ ref('stg_bookings') }}
{% if is_incremental() %}
  where created_at > (select max(created_at) from {{ this }})
{% endif %}