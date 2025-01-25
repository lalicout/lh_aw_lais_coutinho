
with specialoffer_raw as (

    select * 
    from {{ source('sales', 'specialoffer') }}

),

specialoffer_transformation as (

    select

        specialofferid as special_offer_id
        , discountpct as discount_percentage
        , "TYPE" as type_offer
        , category as category
        , cast(startdate as date) as start_dt
        , enddate as end_dt
    
    from specialoffer_raw

)

select * 
from specialoffer_transformation
