with estados_paises as (
    select
        sp.id_state_province as fk_estado
        , sp.state_province_name as nome_estado
        , sp.state_province_code as codigo_estado
        , sp.id_territory as fk_territorio
        , cr.country_region_code as codigo_pais
    from {{ ref('stg_person_state_province') }} sp
    left join {{ ref('stg_person_region_country') }} cr
        on sp.country_region_code = cr.country_region_code
),
regioes as (
    select
        t.territory_id as fk_territorio
        , t.territory_name as nome_territorio
        , t.territory_group as zona_geografica
    from {{ ref('stg_sales_salesterritory') }} t
),
enderecos as (
    select
        a.addressid as fk_endereco
        , a.addressline1 as endereco
        , a.addressline2 as complemento
        , a.city as cidade
        , a.stateprovinceid as fk_estado
        , a.postal_code 
    from {{ ref('stg_person_address') }} a
),
join_tabelas as (
    select
        e.fk_estado
        , e.nome_estado
        , e.codigo_estado
        , e.codigo_pais
        , r.fk_territorio
        , r.nome_territorio
        , r.zona_geografica
        , d.fk_endereco
        , d.endereco
        , d.complemento
        , d.cidade
        , d.postal_code
    from estados_paises e
    left join regioes r
        on e.fk_territorio = r.fk_territorio
    left join enderecos d
        on e.fk_estado = d.fk_estado
    where e.fk_estado is not null
      and e.fk_territorio is not null
)
select *
from join_tabelas

