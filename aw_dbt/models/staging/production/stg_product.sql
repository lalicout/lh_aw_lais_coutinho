
with product_raw as (
    select * 
    from {{ source('production', 'product') }}
),

product_transformation as (
    
    select
        
        productid as product_id
        , "NAME" as product_name
        , productsubcategoryid as product_subcategory_id
        
    from product_raw 

)

select * from product_transformation
