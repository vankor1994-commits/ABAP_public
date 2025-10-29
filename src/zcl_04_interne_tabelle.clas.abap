CLASS zcl_04_interne_tabelle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_INTERNE_TABELLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*****************CORRESPONDING***********************************************
    DATA gt_carrier TYPE TABLE OF /dmo/carrier.
    DATA gt_flight TYPE TABLE OF /dmo/flight.
    SELECT * FROM /dmo/flight INTO TABLE @gt_flight.
    SELECT * FROM /dmo/carrier INTO TABLE @gt_carrier.
*    gt_carrier = CORRESPONDING #( gt_flight ).
* out->write( gt_carrier ).

**************MAPPING********************************************************
    TYPES: BEGIN OF ty_carrier,
             id   TYPE c LENGTH 3,
             nam TYPE string,
             last_chan_at type p LENGTH 11 DECIMALS 7,
           END OF ty_carrier.
    DATA result_mapp TYPE TABLE OF ty_carrier.
    result_mapp = CORRESPONDING #( gt_carrier
*                          MAPPING id  = carrier_id
                                  ).
   out->write( result_mapp ) .


**********************************************************************
    DATA gt_connection TYPE TABLE OF /dmo/connection.
    DATA gt_airport TYPE TABLE OF /dmo/airport.

    SELECT * FROM /dmo/connection INTO TABLE @gt_connection.
    SELECT * FROM /dmo/airport INTO TABLE @gt_airport.

    TYPES: BEGIN OF ty_result,
             carrier_id        TYPE /dmo/connection-carrier_id,
             carrier_name      TYPE /dmo/carrier-name,
             airport_from      TYPE /dmo/connection-airport_from_id,
             airport_from_name TYPE /dmo/airport-name,
             airport_to        TYPE /dmo/connection-airport_to_id,
             airport_to_name   TYPE /dmo/airport-name,

           END OF ty_result.

    DATA gt_result TYPE sorted TABLE OF ty_result with NON-UNIQUE key carrier_id.
    gt_result = VALUE #( FOR line IN gt_connection
*                            WHERE ( carrier_id = 'LH' )
*                            from 1 to 5
                            (
                           carrier_id        = line-carrier_id
                           carrier_name      = gt_carrier[ carrier_id = line-carrier_id ]-name
                           airport_from      = line-airport_from_id
                           airport_from_name = gt_airport[ airport_id = line-airport_from_id ]-name
                           airport_to        = line-airport_to_id
                           airport_to_name   = gt_airport[ airport_id = line-airport_to_id ]-name

                                ) ).
    DATA(sum) = REDUCE i( INIT total = 0
                          FOR count IN gt_result
                          NEXT total += 1 ).

      data lh_conn type TABLE OF ty_result.
     LOOP AT gt_result INTO DATA(connection).
     if connection-carrier_id = 'LH' .
     append connection to lh_conn.
      endif.
      ENDLOOP.

      CONSTANTS c_lh type c LENGTH 3 value 'LH'.
      data(lh_conn_2) = FILTER #( gt_result where carrier_id = c_lh )  .

*     out->write( lh_conn ).
*     out->write( lh_conn_2 ).
**   out->write( gt_result ) .
*    out->write( |Result: { sum }| ).
  ENDMETHOD.
ENDCLASS.
