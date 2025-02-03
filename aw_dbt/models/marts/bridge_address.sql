with envio as (
    select distinct 
        pedido_id
        , fk_endereco_de_envio as fk_endereco
        , 'envio' as tipo_endereco
    from  {{ ref('fato_vendas') }} 
),
faturamento as (
    select distinct
         pedido_id
        , fk_endereco_faturamento as fk_endereco
        , 'faturamento' as tipo_endereco
    from  {{ ref('fato_vendas') }} 
),
juncao_tabelas as (

    select * from envio
    union all
    select * from faturamento

)
select distinct 
    fk_endereco
    , pedido_id
    , tipo_endereco

from juncao_tabelas
where fk_endereco is not null