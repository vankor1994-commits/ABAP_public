CLASS zcl_04_conversion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_CONVERSION IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data day type d value '20250615'.
    DATA(today) = cl_abap_context_info=>get_system_date(  ).
    SELECT FROM /dmo/flight
    FIELDS price,
           currency_code,
           @today AS date,
           currency_conversion( amount = price,
                               source_currency = currency_code,
                                target_currency = 'EUR',
                                  exchange_rate_date = @day,
                                  on_error  = @sql_currency_conversion=>c_on_error-set_to_null ) AS in_EURO
where currency_code = 'USD'
           INTO TABLE @DATA(gt_booking)
           UP TO 10 ROWS.

    out->write( gt_booking ).
  ENDMETHOD.
ENDCLASS.
