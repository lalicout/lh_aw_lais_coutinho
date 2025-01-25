
with product_inventory_raw as (
    select * 
    from {{ source('production', 'productinventory') }}
),

product_inventory_transformation as (
    
    select
        
        productid as product_id
        , locationid as location_id
        , quantity as quantity
        
    from product_inventory_raw 

)

select * from product_inventory_transformation
