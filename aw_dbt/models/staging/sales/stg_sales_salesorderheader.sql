with salesorderheader_raw as (
    
    select * 
    from {{ source('sales', 'salesorderheader') }}

),

salesorderheader_transformation as (

    select

        salesorderid as sales_order_id
        , cast(orderdate as date) as order_date
        , cast(duedate as date) as due_date
        , cast(shipdate as date) as ship_date
        , "STATUS" as order_current_status
        , onlineorderflag as online_order_flag
        , purchaseordernumber as purchase_order_number
        , accountnumber as account_number
        , customerid as customer_id
        , coalesce(salespersonid, 0) as sales_person_id
        , territoryid as territory_id
        , billtoaddressid as bill_to_address_id
        , shiptoaddressid as ship_to_address_id
        , shipmethodid as ship_method_id
        , creditcardid as credit_card_id
        , creditcardapprovalcode as credit_card_approval_code
        , currencyrateid as currency_rate_id
        , subtotal
        , taxamt as tax_amount
        , freight
        , totaldue as total_due
        , comment

    from salesorderheader_raw

)

select * 
from salesorderheader_transformation
