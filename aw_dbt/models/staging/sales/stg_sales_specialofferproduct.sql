with specialofferproduct_raw as (
    select * 
    from {{ source('sales', 'specialofferproduct') }}
),

specialofferproduct_transformation as (
    
    select
        
        specialofferid as specialoffer_id
        ,productid as person_id
        
    from specialofferproduct_raw 

)

select * from specialofferproduct_transformation