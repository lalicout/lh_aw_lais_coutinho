
with product_category_raw as (
    select * 
    from {{ source('production', 'productcategory') }}
),

product_category_transformation as (
    
    select
        
        productcategoryid as product_category_id
        , "NAME" as product_category_name
        
    from product_category_raw 

)

select * from product_category_transformation
