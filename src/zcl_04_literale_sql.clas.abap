CLASS zcl_04_literale_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_LITERALE_SQL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    CONSTANTS City TYPE string VALUE 'Köln'.
    SELECT FROM /dmo/flight

    FIELDS concat_with_space( carrier_id, connection_id, 1 ) AS carrier,
           seats_max                  as seats,
           seats_occupied             ,
           seats_max - seats_occupied AS Free,

           CASE
           WHEN seats_occupied   >= seats_max THEN 'Voll'
           WHEN seats_occupied   < seats_max  THEN 'Verfügbar'
                       END            AS Status,

           div( seats_occupied * 100 , seats_max )
                                      AS percentage_int,

           division( seats_occupied * 100 , seats_max, 2 )
                                      AS percentage,
            cast( seats_occupied as fltp ) * cast( 100 as fltp ) / cast( seats_max as fltp ) as percentage_fl,
           'AA' AS Name,
           1234 AS number,
           @city AS city

    INTO TABLE @DATA(result)
    UP TO 5 ROWS.
    out->write( result ).
  ENDMETHOD.
ENDCLASS.
