with store_raw as (
    select * 
    from {{ source('sales', 'store') }}
),

store_transformation as (
    
    select
        
        businessentityid as store_id
        , "NAME" as store_name
        , salespersonid as sales_person_id
        
        -- XML extraction demographics

        , xmlget(demographics, 'AnnualSales') AS annual_sales
        , xmlget(demographics, 'AnnualRevenue') AS annual_revenue
        , xmlget(demographics, 'BusinessType') AS business_type
        , xmlget(demographics, 'NumberEmployees') AS number_employees

    from store_raw 

)

select * from store_transformation