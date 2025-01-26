with clientes_b2c as (
    select
        customer.customer_id as pk_cliente
        , person.person_id as fk_pessoa
        , null::integer as fk_loja
        , 'B2C' as tipo_cliente
        , person.full_name::varchar as nome_completo
        , person.gender::varchar as genero
        , person.birth_date::date as dt_nascimento
        , person.date_first_purchase::date as dt_primeira_compra
        , null::varchar as nome_da_loja
        , null::varchar as tipo_negocio
    from {{ ref('stg_sales_customer') }} as customer
    left join {{ ref('stg_person_person') }} as person
        on customer.person_id = person.person_id
    where person.person_type = 'IN' 
    and person.person_id is not null 
    and customer.person_id is not null
),

clientes_b2b as (
    select
        customer.customer_id as pk_cliente
        , null::integer as fk_pessoa
        , store.store_id as fk_loja
        , 'B2B' as tipo_cliente
        , null::varchar as nome_completo
        , null::varchar as genero
        , null::date as dt_nascimento
        , null::date as dt_primeira_compra
        , store.store_name::varchar as nome_da_loja
        , store.business_type::varchar as tipo_negocio
    
    from {{ ref('stg_sales_customer') }} as customer
    left join {{ ref('stg_person_person') }} as person
        on customer.person_id = person.person_id
    left join {{ ref('stg_sales_store') }} as store
        on customer.store_id = store.store_id
    where person.person_type = 'SC'
    and customer.store_id is not null
    and person.person_id is not null
)

select * 
from clientes_b2c
union
select *
from clientes_b2b
