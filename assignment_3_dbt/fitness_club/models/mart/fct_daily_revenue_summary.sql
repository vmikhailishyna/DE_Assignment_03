{{ config(
    materialized='incremental',
    unique_key='payment_date'
) }}

with daily_metrics as (
    select
        payment_date,
        sum(amount) as daily_revenue,
        count(distinct member_id) as unique_paying_members,
        count(payment_id) as total_transactions
    from {{ ref('stg_payments') }}

    {% if is_incremental() %}
      where payment_date >= (select max(payment_date) from {{ this }})
    {% endif %}

    group by 1
),

windowed_metrics as (
    select
        *,
        sum(daily_revenue) over (order by payment_date) as running_total_revenue,
        lag(daily_revenue) over (order by payment_date) as prev_day_revenue,
        avg(daily_revenue) over (order by payment_date rows between 6 preceding and current row) as rolling_avg_7d_revenue
    from daily_metrics
)

select
    *,
    case
        when prev_day_revenue is not null and prev_day_revenue != 0
        then (daily_revenue - prev_day_revenue) / prev_day_revenue * 100
        else null
    end as revenue_growth_pct
from windowed_metrics