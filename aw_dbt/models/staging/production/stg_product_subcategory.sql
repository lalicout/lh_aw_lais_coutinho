
with product_subcategory_raw as (
    select * 
    from {{ source('production', 'productsubcategory') }}
),

product_subcategory_transformation as (
    
    select
        
        productsubcategoryid as product_subcategory_id
        , name as product_subcategory_name
        , productcategoryid as product_category_id
        
    from product_subcategory_raw 

)

select * from product_subcategory_transformation
