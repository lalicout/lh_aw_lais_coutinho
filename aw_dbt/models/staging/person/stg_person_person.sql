/* Main transformation for stg_person_person */

with person_raw as (
    select * 
    from {{ source('person', 'person') }}
),

person_transformation as (
    select
        
        businessentityid as person_id

        -- Standardizing person_type

        ,upper(persontype) as person_type
        
        -- Validating emailpromotion

        ,case 
            when emailpromotion in (0, 1, 2) then emailpromotion
            else null
        end as email_promotion

         -- Concatenating full name

        , initcap(trim(
            coalesce(firstname, '') || ' ' || 
            coalesce(middlename, '') || ' ' || 
            coalesce(lastname, '')
        )) as full_name

        , namestyle
        , initcap(suffix) as suffix
        , initcap(title) as title
        
        --XML extraction demographics

        , xmlget(demographics, 'TotalPurchaseYTD') as total_purchase_ytd      
        , to_date(regexp_replace(to_varchar(xmlget(demographics, 'DateFirstPurchase')), '[^0-9\-]',''), 'YYYY-MM-DD') as date_first_purchase
        , to_date(regexp_replace(to_varchar(xmlget(demographics, 'BirthDate')), '[^0-9\-]', ''), 'YYYY-MM-DD') as birth_date

        , xmlget(demographics, 'Gender') as gender

    from person_raw 
)

select * from person_transformation
