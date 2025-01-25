
with purchaseorderdetail_raw as (

    select * 
    from {{ source('purchasing', 'purchaseorderdetail') }}

),

purchaseorderdetail_transformation as (

    select

        purchaseorderid as purchase_order_id
        ,purchaseorderdetailid as purchase_order_detail_id
        ,duedate as due_date
        ,orderqty as order_quantity
        ,productid as product_id
        ,unitprice as unit_price
        ,receivedqty as received_quantity
        ,rejectedqty as rejected_quantity
        ,modifieddate as modified_date
    
    from purchaseorderdetail_raw

)

select * 
from purchaseorderdetail_transformation
