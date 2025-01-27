
with product_raw as (
    select * 
    from {{ source('production', 'product') }}
),

product_transformation as (
    
    select
    
        productid as product_id
        , "NAME" as product_name
        , productnumber as product_number
        , makeflag as is_manufactured
        , finishedgoodsflag as is_salable
        , color as product_color
        , safetystocklevel as safety_stock_level
        , reorderpoint as reorder_point
        , standardcost as standard_cost
        , listprice as list_price
        , "SIZE" as product_size
        , sizeunitmeasurecode as size_unit_measure
        , "WEIGHT" as product_weight
        , weightunitmeasurecode as weight_unit_measure
        , daystomanufacture as days_to_manufacture
        , productline as product_line
        , class as product_class
        , style as product_style
        , productsubcategoryid as product_subcategory_id
        , productmodelid as product_model_id
        , sellstartdate as sell_start_date
        , sellenddate as sell_end_date
        , discontinueddate as discontinued_date
        
    from product_raw 

)

select * from product_transformation
