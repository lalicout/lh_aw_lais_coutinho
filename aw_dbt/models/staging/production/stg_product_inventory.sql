with product_inventory_raw as (
    select * 
    from {{ source('production', 'productinventory') }}
),

product_inventory_transformation as (
    select
        productid as product_id
        , locationid as location_id
        , shelf as storage_shelf
        , bin as storage_bin
        , quantity as inventory_quantity
        
    from product_inventory_raw
)

select *
from product_inventory_transformation
