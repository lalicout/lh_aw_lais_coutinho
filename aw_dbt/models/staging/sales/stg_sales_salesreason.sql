with salesreason_raw as (
    select * 
    from {{ source('sales', 'salesreason') }}
),

salesreason_transformation as (
    
    select
        
        salesreasonid as sales_reason_id
        , "NAME" as sales_description
        , reasontype as sales_reason_category
        
    from salesreason_raw 

)

select * from salesreason_transformation