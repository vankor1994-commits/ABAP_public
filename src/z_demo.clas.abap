CLASS z_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_DEMO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    DATA(today) = cl_abap_context_info=>get_system_date(  ).
*    DATA(day_x)  = CONV d( '20250830' ).
*    out->write( |{ day_x - cl_abap_context_info=>get_system_date(  ) } Days!|  ).

    DATA gt_carrier TYPE SORTED TABLE OF /dmo/carrier WITH non-UNIQUE KEY carrier_id.
    DATA gs_carrier TYPE /dmo/carrier.

    SELECT * FROM /dmo/carrier INTO TABLE @gt_carrier.

    gs_carrier = gt_carrier[ carrier_id = 'AA' ].

    insert gs_carrier inTO table gt_carrier.

    gs_carrier = gt_carrier[ carrier_id = 'AA' ].
    read table gt_carrier WITH KEY carrier_id = 'AA' into data(gs_carrier_2).
    if gs_carrier = gs_carrier_2.
    out->write( |Gleich!| ).
    ENDIF.

    INSERT VALUE #( carrier_id    = 'AA'
                    name          = ' '
                    currency_code = 'EUR' )
                                            INTO TABLE gt_carrier.

    insert gt_carrier[ carrier_id = 'AA' ] into table gt_carrier.
    insert lines of gt_carrier into table gt_carrier.





    DELETE ADJACENT DUPLICATES FROM gt_carrier
    COMPARING carrier_id.



    data gt_carr_buff type table of /dmo/carrier.
    select * from /dmo/carrier into table @gt_carr_buff.

    loop at gt_carrier ASSIGNING field-symbol(<fscarr>).
    if <fscarr>-name is INITIAL.
     <fscarr>-name = gt_carr_buff[ carrier_id = <fscarr>-carrier_id ]-name.
    endif.
    ENDLOOP.

    data(sum) = reduce i( init total = 1
                           for count in gt_carrier
                           next total += 1 ).



*    DATA gt_connection TYPE table of /dmo/connection.
*    gt_connection = CORRESPONDING #( gt_carrier ).
*    out->write( gt_connection ).
out->write( gt_carrier ).

  ENDMETHOD.
ENDCLASS.
