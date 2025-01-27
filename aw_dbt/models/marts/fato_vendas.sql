    select
        
        sod.sales_order_id
        , dp.pk_produto as fk_produto
        , dc.pk_cliente as fk_cliente
        , dv.pk_vendedor as fk_vendedor
        , dr.fk_territorio as fk_territorio
        , dd.date as dt_venda
        , sod.order_qty as quantidade_vendida
        , sod.unit_price * sod.order_qty as receita_bruta
        , sod.unit_price_discount * sod.order_qty as desconto_aplicado
        , (sod.unit_price * sod.order_qty) - (sod.unit_price_discount * sod.order_qty) as receita_liquida

    from {{ ref('stg_sales_salesorderdetail') }} sod
    inner join {{ ref('stg_sales_salesorderheader') }} soh
        on sod.sales_order_id = soh.sales_order_id
    
    inner join {{ ref('dim_produtos') }} dp
        on sod.product_id = dp.pk_produto
    
    inner join {{ ref('dim_clientes') }} dc
        on soh.customer_id = dc.pk_cliente
    
    inner join {{ ref('dim_vendedor') }} dv
        on soh.sales_person_id = dv.pk_vendedor
    
    inner join {{ ref('dim_local') }} dr
        on soh.territory_id = dr.fk_territorio
    
    inner join {{ ref('dim_dates') }} dd
        on soh.order_date = dd.date

