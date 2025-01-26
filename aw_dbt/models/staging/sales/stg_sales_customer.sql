with customer_raw as (
    select * 
    from {{ source('sales', 'customer') }}
),

customer_transformation as (
    
    select
        
        customerid as customer_id
        , personid as person_id
        , storeid as store_id
        , territoryid as territory_id

    from customer_raw 

)

select * from customer_transformation