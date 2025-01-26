with all_dates as (
    select 
        min(due_date) as dt_inicial
        , max(due_date) as end_date
    from {{ ref('stg_purchase_purchaseorderdetail') }}

    union all

    select 
        min(order_date) as dt_inicial
        , max(order_date) as end_date
    from {{ ref('stg_purchase_purchaseorderheader') }}

    union all

    select 
        min(order_date) as dt_inicial
        , max(order_date) as end_date
    from {{ ref('stg_sales_salesorderheader') }}

    union all

    select 
        min(due_date) as dt_inicial
        , max(due_date) as end_date
    from {{ ref('stg_sales_salesorderheader') }}

    union all

    select 
        min(ship_date) as dt_inicial
        , max(ship_date) as end_date
    from {{ ref('stg_sales_salesorderheader') }}
),

date_interval as (
    select 
        min(dt_inicial) as dt_inicial
        , max(end_date) as end_date
    from all_dates
),

date_cte as (

    select 
        (select dt_inicial from date_interval) as date
    union all
    select 
        dateadd(day, 1, date)
    from date_cte
    where date < (select end_date from date_interval)

)

select
    date
    , year(date) as ano
    , month(date) as mes
    , day(date) as dia
    , to_char(date, 'MON') as nome_mes
    , to_char(date, 'DY') as dia_da_semana
    , quarter(date) as trimestre

from date_cte
