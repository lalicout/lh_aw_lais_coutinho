with salesperson_raw as (
    
    select * 
    from {{ source('sales', 'salesperson') }}

),

salesperson_transformation as (

    select

        businessentityid as sales_person_id
        , territoryid as territory_id
        , salesquota as sales_quota
        , bonus as bonus_amount
        , commissionpct as commission_percentage
        , salesytd as sales_year_to_date
        , saleslastyear as sales_last_year

    from salesperson_raw

)

select * 
from salesperson_transformation
