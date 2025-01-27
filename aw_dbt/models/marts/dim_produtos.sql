select
    
    p.product_id as pk_produto
    , p.product_name as nome_produto
    , s.product_subcategory_name as subcategoria_produto
    , c.product_category_name as categoria_produto
    , p.standard_cost as custo_padrao
    , p.list_price as preco_venda
    , p.safety_stock_level as estoque_seguranca
    , p.reorder_point as ponto_reposicao
    , p.product_size as tamanho_produto
    , p.product_weight as peso_produto
    , p.sell_start_date as data_inicio_vendas
    , p.sell_end_date as data_fim_vendas
    , p.discontinued_date as data_descontinuacao
    , case 
        when p.discontinued_date is not null then 1
        else 0
      end as flag_descontinuado

from {{ ref('stg_product') }} p
left join {{ ref('stg_product_subcategory') }} s
    on p.product_subcategory_id = s.product_subcategory_id
left join {{ ref('stg_product_category') }} c
    on s.product_category_id = c.product_category_id
