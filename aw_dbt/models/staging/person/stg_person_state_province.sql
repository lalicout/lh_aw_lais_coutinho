with state_province_raw as (
    select * 
    from {{ source('person', 'stateprovince') }}
),

state_province_transformation as (
    select
        
        stateprovinceid as id_state_province
        , stateprovincecode as state_province_code
        , territoryid as id_territory
        , countryregioncode as country_region_code
        , initcap(name) as state_province_name
        , isonlystateprovinceflag as is_only_state_province_flag
        
    from state_province_raw
)

select * 
from state_province_transformation