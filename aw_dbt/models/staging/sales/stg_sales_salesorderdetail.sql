with salesorderdetail_raw as (
    
    select * 
    from {{ source('sales', 'salesorderdetail') }}

),

salesorderdetail_transformation as (

    select
        
        salesorderid as sales_order_id
        , salesorderdetailid as sales_order_detail_id
        , coalesce(carriertrackingnumber, 'UNTRACKED') as carrier_tracking_number
        , orderqty as order_qty
        , productid as product_id
        , unitprice as unit_price
        , unitpricediscount as unit_price_discount
        , specialofferid as special_offer_id

    from salesorderdetail_raw

)    

select * from salesorderdetail_transformation
