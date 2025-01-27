with fornecedores as (
   
    select *
    
    from {{ ref('stg_purchase_vendor') }}
),

produtos_por_fornecedor as (
    
    select
       
        vendor_id
        , count(distinct product_id) as quantidade_produtos
        , avg(average_lead_time) as lead_time_medio
   
    from {{ ref('stg_purchase_productvendor') }}
    group by vendor_id
),

person_vendor as (
    select
     
        p.person_id as vendor_id
        , p.full_name as nome_fornecedor
    
    from {{ ref('stg_person_person') }} p
    where p.person_type = 'VC'
),

dim_fornecedores as (
    
    select
       
        f.vendor_id as pk_fornecedor
        , pv.nome_fornecedor
        , f.credit_rating as classificacao_credito

        , case 
            when f.preferred_vendor_status = true then 'Sim'
            else 'Não'
        end as status_preferencial

        , case 
            when f.active_flag = true then 'Ativo'
            else 'Inativo'
        end as status_ativo

        , p.lead_time_medio
        , p.quantidade_produtos
    
    from fornecedores f
    
    left join produtos_por_fornecedor p
        on f.vendor_id = p.vendor_id
   
    left join person_vendor pv
        on f.vendor_id = pv.vendor_id

)

select *
from dim_fornecedores
