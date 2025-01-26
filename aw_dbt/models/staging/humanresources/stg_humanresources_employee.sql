
with employee_raw as (

    select * 
    from {{ source('humanresources', 'employee') }}

),

employee_transformation as (

    select

        businessentityid as employee_id
        , nationalidnumber as national_id_number
        , loginid as login_id
        , jobtitle as job_title
        , birthdate as birth_date
        , gender as gender
        , cast(hiredate as date) as hire_date
        , salariedflag as salaried_flag
        , vacationhours as vacation_hours
        , sickleavehours as sick_leave_hours
        , currentflag as current_flag
    
    from employee_raw

)

select * 
from employee_transformation