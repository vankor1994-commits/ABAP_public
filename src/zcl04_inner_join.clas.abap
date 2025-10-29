CLASS zcl04_inner_join DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl04_inner_join IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/connection AS c1
              INNER JOIN /dmo/connection AS c2   ON c1~airport_to_id = c2~airport_from_id
                                                     AND c2~airport_to_id <> c1~airport_from_id

FIELDS
     c1~airport_from_id  AS city_from,
     c1~airport_to_id AS connecting,
     c2~airport_to_id AS city_to,
     c1~distance + c2~distance AS distance_all

     UNION

     SELECT FROM /dmo/connection
     FIELDS airport_from_id AS city_from,
     '-'   AS connecting,
            airport_to_id AS city_to,
            distance AS distance_all
        ORDER BY city_from, city_to, distance_all ASCENDING

     INTO TABLE @DATA(result).



    out->write( result ).


  ENDMETHOD.
ENDCLASS.
