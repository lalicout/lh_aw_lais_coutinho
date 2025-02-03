with fato_vendas as (
    select
        soh.sales_order_id as pedido_id
        , sod.sales_order_detail_id as detalhe_pedido_id
        , soh.customer_id as cliente_id
        , soh.sales_person_id as vendedor_id
        , soh.territory_id as territorio_id
        , sod.product_id as produto_id
        , soh.order_date as data_pedido
        , soh.due_date as data_vencimento
        , soh.ship_date as data_envio
        , COALESCE(sod.order_qty, 0) as quantidade_pedida
        , COALESCE(sod.unit_price, 0) as preco_unitario
        , COALESCE(sod.unit_price_discount, 0) as desconto_unitario
        , COALESCE(sod.unit_price, 0) * COALESCE(sod.order_qty, 0) as receita_bruta
        , COALESCE(sod.unit_price, 0) * COALESCE(sod.order_qty, 0) * (1 - COALESCE(sod.unit_price_discount, 0)) as receita_liquida
        , coalesce(sod.unit_price, 0) * coalesce(sod.order_qty, 0) * coalesce(sod.unit_price_discount, 0) as valor_desconto
        , sum(coalesce(sod.unit_price, 0) * coalesce(sod.order_qty, 0) * (1 - coalesce(sod.unit_price_discount, 0))) 
          over (partition by soh.sales_order_id) as ticket_medio_pedido
        , COALESCE(soh.tax_amount, 0) as valor_imposto
        , COALESCE(soh.freight, 0) as valor_frete
        , COALESCE(soh.total_due, 0) as valor_total
        , soh.online_order_flag as pedido_online
        , sod.carrier_tracking_number as numero_rastreamento
        , soh.comment as comentario_venda
        , soh.bill_to_address_id as fk_endereco_faturamento
        , soh.ship_to_address_id as fk_endereco_de_envio
        , sod.tipo_promocao as status_oferta

    from
        {{ ref('stg_sales_salesorderheader') }} soh
        left join
        {{ ref('int_sales_order_detail') }} sod
        on
        soh.sales_order_id = sod.sales_order_id
)
select *
from fato_vendas