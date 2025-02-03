with clientes_b2c as (
    
    select
        customer.customer_id as pk_cliente
        , customer.person_id as fk_pessoa
        , customer.store_id as fk_loja
        , 'B2C' as tipo_cliente
        , person.full_name as nome_completo
        , person.gender as genero
        , person.birth_date as dt_nascimento
        , person.date_first_purchase as dt_primeira_compra
        , 'Compra Online' as nome_da_loja
        , null as tipo_negocio
    from {{ ref('stg_sales_customer') }} as customer
    inner join {{ ref('stg_person_person') }} as person
        on customer.person_id = person.person_id
        and person.person_type = 'IN'
),

clientes_b2b as (
    select
        customer.customer_id as pk_cliente
        , customer.person_id as fk_pessoa
        , customer.store_id as fk_loja
        , 'B2B' as tipo_cliente
        , person.full_name as nome_completo
        , person.gender as genero
        , person.birth_date as dt_nascimento
        , person.date_first_purchase as dt_primeira_compra
        , store.store_name as nome_da_loja
        , store.business_type as tipo_negocio

    from {{ ref('stg_sales_customer') }} as customer
    inner join {{ref('stg_person_person')}} as person 
        on person.person_id = customer.person_id and person_type = 'SC'
    inner join {{ ref('stg_sales_store') }} as store
        on customer.store_id = store.store_id
    
),

juncao_cliente as (

    select * from clientes_b2c
    union all
    select * from clientes_b2b
)

select * from juncao_cliente

