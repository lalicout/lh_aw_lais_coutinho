with salesorderheadersalesreason_raw as (
    
    select * 
    from {{ source('sales', 'salesorderheadersalesreason') }}

),

salesorderheadersalesreason_transformation as (

    select

        salesorderid as sales_order_id
        , salesreasonid as sales_reason_id
    
    from salesorderheadersalesreason_raw

)

select * 
from salesorderheadersalesreason_transformation
