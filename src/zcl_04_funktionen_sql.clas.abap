CLASS zcl_04_funktionen_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_FUNKTIONEN_SQL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA f_Name TYPE c LENGTH 20 VALUE 'ivan'.
    DATA l_Name TYPE c LENGTH 40 VALUE 'koropetskyi'.
    DATA b_day  TYPE d VALUE '19940522'.
    data(today) = cl_abap_context_info=>get_system_date(  ).
    data(time) = cl_abap_context_info=>get_system_time(  ).

    SELECT FROM /dmo/customer
    FIELDS
           @l_name AS last_name,
           concat_with_space( initcap( @f_name ), initcap( @l_name ), 1 )   AS fuul,

           upper( concat( left( @f_name, 1 ) , left( @l_name, 1 ) ) )       AS init,

           concat_with_space( concat( upper( left( @f_name, 1 ) ), '.' ) , initcap( @l_name ), 1 )  AS short,

           @b_day    AS birthday,

           right( @b_day, 2 )        AS day,
           substring( @b_day, 5, 2 ) AS month,
           left( @b_day, 4 )         AS year,
           weekday( @b_day )         as day_name,
           monthname( @b_day )       as month_name,
           extract_year( @b_day )    as year_ex

    INTO TABLE @DATA(gt_customer)
    UP TO 1 ROWS.
    out->write( gt_customer ).
  ENDMETHOD.
ENDCLASS.
