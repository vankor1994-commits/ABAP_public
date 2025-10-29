class ZCL04_INNER_JOIN definition
  public
  final
  create public .

public section.
protected section.
private section.
ENDCLASS.



CLASS ZCL04_INNER_JOIN IMPLEMENTATION.


    SELECT FROM /dmo/connection AS c1
                inner JOIN /dmo/connection AS c2   ON c1~airport_to_id = c2~airport_from_id
                                                       AND c2~airport_to_id <> c1~airport_to_id
                
FIELDS
       c1~airport_from_id  as from,
       c1~airport_to_id as connecting,
       c2~airport_to_id as to

       INTO table @data(result).
ENDCLASS.
