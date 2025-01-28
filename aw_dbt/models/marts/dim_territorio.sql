    select
    

        territory_id as pk_territorio
        , territory_name as nome_territorio
        , country_region_code as codigo_pais
        , territory_group as zona_geografica

    
     from {{ ref('stg_sales_salesterritory') }} 


