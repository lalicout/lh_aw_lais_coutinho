with join_sales as (
    select
        sod.product_id as product_id,
        soh.order_date as order_date,
        soh.territory_id as territory_id,
        sod.order_qty as order_qty,
        sod.unit_price as unit_price
    from {{ ref('stg_sales_salesorderdetail') }} sod
    inner join {{ ref('stg_sales_salesorderheader') }} soh
        on sod.sales_order_id = soh.sales_order_id
),

group_sales as (
    select
        dp.nome_produto as nome_produto,
        dd.date as data,
        dd.mes as mes,
        dd.ano as ano,
        dr.nome_territorio as nome_territorio,
        sum(js.order_qty) as quantidade_vendida,
        sum(js.unit_price * js.order_qty) as receita_bruta
    from join_sales js
    inner join {{ ref('dim_produtos') }} dp
        on js.product_id = dp.pk_produto
       and dp.flag_descontinuado = 0
    inner join {{ ref('dim_dates') }} dd
        on js.order_date = dd.date
    inner join {{ ref('dim_local') }} dr
        on js.territory_id = dr.fk_territorio
    group by 
        dp.nome_produto, dd.date, dd.mes, dd.ano, dr.nome_territorio
),

abc_requirements as (
    select

        *,
        sum(receita_bruta) over (partition by ano order by receita_bruta desc) as receita_acumulada,
        sum(receita_bruta) over (partition by ano) as receita_total_ano,
        sum(receita_bruta) over (partition by ano order by receita_bruta desc) 
            / sum(receita_bruta) over (partition by ano) as percentual_acumulado,
        case 
            when sum(receita_bruta) over (partition by ano order by receita_bruta desc) 
                 / sum(receita_bruta) over (partition by ano) <= 0.8 then 'a' 
            when sum(receita_bruta) over (partition by ano order by receita_bruta desc) 
                 / sum(receita_bruta) over (partition by ano) <= 0.95 then 'b' 
            else 'c' 
        end as grupo_abc
    from group_sales
)

select *
from abc_requirements
