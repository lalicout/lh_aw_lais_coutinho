
with purchaseorderheader_raw as (

    select * 
        from {{ source('purchasing', 'purchaseorderheader') }}

),

purchaseorderheader_transformation as (

    select

        purchaseorderid as purchase_order_id
        ,revisionnumber as revision_number
        ,status as status
        ,employeeid as employee_id
        ,vendorid as vendor_id
        ,shipmethodid as ship_method_id
        ,orderdate as order_date
        ,subtotal as subtotal
        ,taxamt as tax_amount
        ,freight as freight_cost
    
    from purchaseorderheader_raw

)

select * 
from purchaseorderheader_transformation
