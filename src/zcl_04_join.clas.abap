CLASS zcl_04_join DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_JOIN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT * FROM /dmo/flight INTO TABLE @DATA(gt_flight).

    TYPES: BEGIN OF ty_result,
             id        TYPE c LENGTH 4,
             from_id   TYPE c LENGTH 4,
             to_id     TYPE c LENGTH 4,
             date      TYPE d,
             departure TYPE t,
             cust_id   TYPE c LENGTH 7,
             name      TYPE c LENGTH 40,
             price     TYPE p LENGTH 5 DECIMALS 2,
           END OF ty_result .

    DATA result1 TYPE standard TABLE OF ty_result WITH EMPTY KEY.
    SELECT FROM /dmo/flight AS flight
                LEFT OUTER JOIN /dmo/connection AS c   ON flight~carrier_id    = c~carrier_id
                                                       AND flight~connection_id = c~connection_id
                LEFT OUTER JOIN /dmo/booking AS book   ON  flight~carrier_id    = book~carrier_id
                                                       AND c~connection_id      = book~connection_id
                                                       AND flight~flight_date   = book~flight_date
                 LEFT OUTER JOIN /dmo/customer AS cust ON book~customer_id    = cust~customer_id
FIELDS
       flight~carrier_id  AS id,
       c~airport_from_id  AS from_id,
       c~airport_to_id    AS to_id,
       flight~flight_date AS date,
       c~departure_time   AS departure,
       cust~customer_id   AS cust_id,
       concat_with_space( cust~first_name, cust~last_name, 1 ) AS name,
       book~flight_price AS price
WHERE flight~carrier_id = 'JL' AND flight~flight_date = '20260116'
ORDER BY cust_id


       INTO table @data(result).
    DELETE ADJACENT DUPLICATES FROM result COMPARING cust_id.

    DATA(sum) = REDUCE i( INIT total = 0
                          FOR count IN result
                          NEXT total += 1 ).

    DATA(sum_price) = REDUCE #( INIT total = 0
                                FOR count IN result
                                NEXT total = total + count-price  ).
     data sum1 type i VALUE 0 .
    loop AT  result into data(gt_result).
      sum1 +=  gt_result-price .
      ENDLOOP.


    DATA(sum_gt_flight) =  gt_flight[ carrier_id = 'JL'  flight_date = '20260116' ]-seats_occupied.
*    out->write( |occupied by /dmo/ : { sum_gt_flight }| ).
*    out->write( |occupied by result: { sum }| ).
*    out->write( |duplicate: { sum_gt_flight - sum }| ) .
*    out->write( result ).
     out->write( sum_price ).
     out->write( sum1 ).


  ENDMETHOD.
ENDCLASS.
