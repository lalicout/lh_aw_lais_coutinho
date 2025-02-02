select

    sp.sales_person_id as pk_vendedor
    , p.full_name as nome_vendedor
    , e.job_title as cargo
    , sp.territory_id as fk_territorio
    , sp.sales_quota as meta_vendas
    , e.hire_date as data_contratacao

    , case 
        when e.current_flag = 1 then 'Ativo'
        else 'Desligado'
      end as status_vendedor

    , e.gender as genero

    , e.birth_date as data_nascimento
    

from {{ ref('stg_sales_salesperson') }} sp
left join {{ ref('stg_humanresources_employee') }} e
    on sp.sales_person_id = e.employee_id
left join {{ ref('stg_person_person') }} p
    on sp.sales_person_id = p.person_id and p.person_type = 'SP'

