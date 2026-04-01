with source as (
    select * from {{ ref('raw_membership_plans') }}
)
select
    plan_id,
    plan_name,
    price,
    duration_weeks,
    case when has_group_training = 1 then true else false end as is_group_allowed,
    case when has_co_access = 1 then true else false end as is_network_access,
    case when has_safe = 1 then true else false end as is_group_allowed,
    case when has_guest_pass = 1 then true else false end as is_network_access,
    case when has_unlimited_body_composition = 1 then true else false end as is_group_allowed,
from source