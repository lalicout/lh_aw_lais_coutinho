/* Main transformation for stg_person_address */

with address_raw as (
    
    select * 
    from {{ source('person', 'address')}}
),

address_transformation as (
    select

        addressid
        , initcap(addressline1) as addressline1
        , initcap(addressline2) as addressline2
        , initcap(city) as city
        , stateprovinceid
        , coalesce(postalcode, 'UNKNOWN') as postal_code

    from address_raw
)

select * 
from address_transformation