CLASS z_demo_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_DEMO_SELECT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  SELECT  from /dmo/flight
  FIELDS
    carrier_id,
   max( plane_type_id ) as abc

    GROUP BY carrier_id



       into table @DATA(result)
       .
   out->write( result ).
  ENDMETHOD.
ENDCLASS.
