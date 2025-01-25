with salesterritory_raw as (
    
    select * 
    from {{ source('sales', 'salesterritory') }}

),

salesterritory_transformation as (

    select

        territoryid as territory_id
        , "NAME" as territory_name
        , countryregioncode as country_region_code
        , "GROUP" as territory_group
        , salesytd as sales_year_to_date
        , saleslastyear as sales_last_year
        , costytd as cost_year_to_date
        , costlastyear as cost_last_year
    
    from salesterritory_raw

)

select * 
from salesterritory_transformation
