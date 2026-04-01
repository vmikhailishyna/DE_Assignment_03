{{ config(
    materialized='incremental',
    unique_key='payment_id'
) }}

select * from {{ ref('stg_payments') }}
{% if is_incremental() %}
  where payment_date > (select max(payment_date) from {{ this }})
{% endif %}