    select 
        sod.*
        , case 
            when so.category in ('Excess Inventory', 'Discontinued Product') then 'B2B - Estoque em Excesso ou Descontinuado'
            when so.category = 'Volume Discount' then 'B2B - Desconto por Volume'
            when so.category = 'Seasonal Discount' then 'B2C - Desconto Sazonal'
            when so.category = 'New Product' then 'B2B - Novo Produto'
            else 'B2C - Sem promoção específica'
        end as tipo_promocao
    from {{ ref('stg_sales_salesorderdetail') }}  sod
    left join {{ ref('stg_sales_specialoffer') }} so on sod.special_offer_id = so.special_offer_id
