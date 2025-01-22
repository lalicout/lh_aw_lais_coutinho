with state_province_raw as (
    select * 
    from {{ source('PERSON', 'STATEPROVINCE') }}
),

state_province_transformation as (
    select
        
        stateprovinceid as id_state_province
        ,stateprovincecode as state_province_code
        ,territoryid as id_territory
        ,countryregioncode as country_region_code
        ,initcap(name) as state_province_name
        ,isonlystateprovinceflag as state_province_flag
        ,rowguid as rowguide

    from state_province_raw
)

select * 
from state_province_transformation