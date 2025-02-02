with purchase_data as (
    
    select

        pod.product_id as fk_produto
        , poh.vendor_id as fk_fornecedor
        , poh.ship_method_id as fk_metodo_envio
        , poh.order_date as data_pedido
        , pod.order_quantity
        , pod.received_quantity
        , pod.rejected_quantity
        , pod.unit_price * pod.received_quantity as custo_total
    
    from {{ ref('stg_purchase_purchaseorderdetail') }} pod
    left join {{ ref('stg_purchase_purchaseorderheader') }} poh
        on pod.purchase_order_id = poh.purchase_order_id
),
joined_with_supplier as (
    
    select
    
        pd.fk_produto
        , pd.fk_fornecedor
        , pd.fk_metodo_envio
        , pd.data_pedido
        , dp.nome_produto
        , vf.nome_fornecedor
        , pd.order_quantity
        , pd.received_quantity
        , pd.rejected_quantity
        , pd.custo_total
    
    from purchase_data pd
    left join {{ ref('dim_produtos') }} dp
        on pd.fk_produto = dp.pk_produto
    left join {{ ref('dim_fornecedor') }} vf
        on pd.fk_fornecedor = vf.pk_fornecedor
)
select *
from joined_with_supplier
