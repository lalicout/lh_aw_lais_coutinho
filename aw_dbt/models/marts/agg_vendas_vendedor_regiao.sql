select

    fv.vendedor_id,
    dl.nome_territorio,
    dl.zona_geografica,
    sum(fv.quantidade_pedida) as total_quantidade_vendida,
    sum(fv.receita_bruta) as total_receita_bruta,
    sum(fv.receita_liquida) as total_receita_liquida,
    sum(fv.valor_desconto) as total_valor_desconto,
    sum(fv.valor_total) as total_valor_total

from {{ ref('fato_vendas') }} fv
left join {{ ref('dim_local') }} dl
    on fv.territorio_id = dl.fk_territorio 

where fv.status_pedido = 'Concluído' /* considera somente as vendas efetivadas */

group by
    fv.vendedor_id,
    dl.nome_territorio,
    dl.zona_geografica
order by
    dl.nome_territorio,
    fv.vendedor_id