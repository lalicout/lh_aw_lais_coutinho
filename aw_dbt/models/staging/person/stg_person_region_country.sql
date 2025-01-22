/* Main transformation for stg_person_region_country */

with country_region_raw as (

    select * 
    from {{ source('PERSON', 'COUNTRYREGION') }}
    
),

country_region_transformation as (
    select

        countryregioncode as country_region_code
        ,initcap(name) as country_name

    from country_region_raw
)

select * 
from country_region_transformation
