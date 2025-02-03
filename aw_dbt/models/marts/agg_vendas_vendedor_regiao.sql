with 
    fato_vendas as (
        select * from {{ ref('fato_vendas') }}
    ),
    
    dim_produtos as (
        select * from {{ ref('dim_produtos') }}
    ),
    
    dim_clientes as (
        select * from {{ ref('dim_clientes') }}
    ),
    
    join_enderecos as (
       
         select 
              a.addressid as fk_endereco_faturamento
              , a.city as cidade
              , sp.state_province_name as estado
              , cr.country_name as pais

        from {{ ref('stg_person_address') }} a
        left join {{ ref('stg_person_state_province') }} sp
            on a.stateprovinceid = sp.id_state_province
        left join {{ ref('stg_person_region_country') }} cr
            on sp.country_region_code = cr.country_region_code
        ),
            
        agg_vendas_vendedor_regiao as (
        select
            je.pais
            , je.estado
            , je.cidade
            , dc.nome_da_loja
            , dp.nome_produto
            , dp.categoria_produto
            , dp.subcategoria_produto
            , dp.pk_produto
            , fv.quantidade_pedida
            , fv.preco_unitario
            , fv.data_pedido
            , fv.vendedor_id
 
                
        from fato_vendas fv
        inner join dim_clientes dc on fv.cliente_id = dc.pk_cliente
        left join join_enderecos je on je.fk_endereco_faturamento = fv.cliente_id
        left join dim_produtos dp on fv.produto_id = dp.pk_produto
        )

    select * from agg_vendas_vendedor_regiao
