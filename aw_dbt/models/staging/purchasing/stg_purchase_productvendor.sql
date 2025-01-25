
with productvendor_raw as (

    select * 
        from {{ source('purchasing', 'productvendor') }}

),

productvendor_transformation as (

    select

        productid as product_id
        ,businessentityid as vendor_id
        ,averageleadtime as average_lead_time
        ,standardprice as standard_price
        ,lastreceiptcost as last_receipt_cost
        ,cast(lastreceiptdate as date) as last_receipt_date
        ,minorderqty as min_order_quantity
        ,maxorderqty as max_order_quantity
        ,onorderqty as on_order_quantity
    
    from productvendor_raw

)

select * 
from productvendor_transformation
