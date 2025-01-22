/* Main transformation for stg_person_person */

with person_raw as (
    select * 
    from {{ source('PERSON', 'PERSON') }}
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

        ,initcap(concat_ws(' ', firstname, middlename, lastname)) as full_name
        ,middlename as middle_name
        ,namestyle
        ,rowguid
        ,initcap(suffix) as suffix
        ,initcap(title) as title
        
        --XML extraction 

        ,xmlget(demographics, 'TotalPurchaseYTD'):"$" as total_purchase_ytd      
        ,xmlget(demographics, '{DateFirstPurchase'):"$" as date_first_purchase
        ,xmlget(demographics, '{BirthDate'):"$" as birth_date
        ,xmlget(demographics, '{YearlyIncome'):"$" as yearly_income
        ,xmlget(demographics, '{Gender'):"$" as gender

    from person_raw 
)

select * from person_transformation
