CLASS zcl_04_fieldsymbol DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_FIELDSYMBOL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data gt_buff type sorted table of /dmo/carrier with UNIQUE key carrier_id.
  data gt_carrier type table of /dmo/carrier with empty KEY .
  SELECT * from /dmo/carrier into table @gt_buff.

  APPEND value #( carrier_id = 'AA' ) to gt_carrier.
  APPEND value #( carrier_id = 'AA' name = 'America' ) to gt_carrier.
  APPEND value #( carrier_id = 'LH' ) to gt_carrier.
  APPEND value #( carrier_id = 'BR' ) to gt_carrier.

*  loop at gt_carrier ASSIGNING  FIELD-SYMBOL(<fs_buff>).
*  if <fs_buff>-name is INITIAL .
*  assign gt_buff[ carrier_id = <fs_buff>-carrier_id ] to FIELD-SYMBOL(<fs_match>).
*   if <fs_match> is ASSIGNED .
*     <fs_buff>-name = <fs_match>-name.
*     UNASSIGN <fs_match>.
*     else. <fs_buff>-name = 'Unknown'.
*  ENDIF.
*  ENDIF.
*  ENDLOOP.

loop at gt_carrier ASSIGNING FIELD-SYMBOL(<fs_buff>).
if sy-subrc = 0.
<fs_buff>-name = gt_buff[ carrier_id = <fs_buff>-carrier_id ]-name.
ENDIF.
ENDLOOP.
out->write( gt_carrier ).
 out->write( 'hjhj' ).





  ENDMETHOD.
ENDCLASS.
