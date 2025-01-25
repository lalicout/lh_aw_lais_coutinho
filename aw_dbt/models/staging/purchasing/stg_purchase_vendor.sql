
with vendor_raw as (

    select * 
    from {{ source('purchasing', 'vendor') }}

),

vendor_transformation as (

    select

        businessentityid as vendor_id
        ,name as vendor_name
        ,creditrating as credit_rating
        ,preferredvendorstatus as preferred_vendor_status
        ,activeflag as active_flag
    
    from vendor_raw

)

select * 
from vendor_transformation
