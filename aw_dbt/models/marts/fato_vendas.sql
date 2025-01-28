with vendas_fato as (
    select
        soh.sales_order_id as pedido_id
        , sod.sales_order_detail_id as detalhe_pedido_id
        , soh.customer_id as cliente_id
        , soh.sales_person_id as vendedor_id
        , soh.territory_id as territorio_id
        , sod.product_id as produto_id
        , soh.bill_to_address_id as endereco_cobranca_id
        , soh.ship_to_address_id as endereco_entrega_id
        , soh.ship_method_id as metodo_envio_id
        , soh.order_date as data_pedido
        , soh.due_date as data_vencimento
        , soh.ship_date as data_envio
        , COALESCE(sod.order_qty, 0) as quantidade_pedida
        , COALESCE(sod.unit_price, 0) as preco_unitario
        , COALESCE(sod.unit_price_discount, 0) as desconto_unitario
        , COALESCE(sod.unit_price, 0) * COALESCE(sod.order_qty, 0) as receita_bruta
        , COALESCE(sod.unit_price, 0) * COALESCE(sod.order_qty, 0) * (1 - COALESCE(sod.unit_price_discount, 0)) as receita_liquida
        , COALESCE(sod.unit_price, 0) * COALESCE(sod.order_qty, 0) * COALESCE(sod.unit_price_discount, 0) as valor_desconto
        , COALESCE(soh.tax_amount, 0) as valor_imposto
        , COALESCE(soh.freight, 0) as valor_frete
        , COALESCE(soh.total_due, 0) as valor_total
        , soh.online_order_flag as pedido_online
        , soh.credit_card_approval_code as codigo_aprovacao_cartao
        , sod.carrier_tracking_number as numero_rastreamento
        , soh.comment as comentario_venda
        , case 
            when soh.order_current_status = 1 then 'Aguardando Pagamento'
            when soh.order_current_status = 2 then 'Processando'
            when soh.order_current_status = 3 then 'Pedido Enviado'
            when soh.order_current_status = 4 then 'Concluído'
            when soh.order_current_status = 5 then 'Cancelado'
            else 'Status Desconhecido'
        end as status_pedido
    from
        {{ ref('stg_sales_salesorderheader') }} soh
        left join
        {{ ref('stg_sales_salesorderdetail') }} sod
        on
        soh.sales_order_id = sod.sales_order_id
)
select *
from vendas_fato

