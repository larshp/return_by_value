REPORT zreturn_test2.

START-OF-SELECTION.
  PERFORM run.

FORM run.

  PERFORM member.
  PERFORM local.

ENDFORM.

FORM member.

  DATA: lo_return TYPE REF TO zcl_return_test2,
        lt_tab    TYPE zcl_return_test=>ty_table_type.

  FIELD-SYMBOLS: <ls_tab> LIKE LINE OF lt_tab.


  CREATE OBJECT lo_return EXPORTING iv_rows = 200000.

  lt_tab = lo_return->return_member( ).
* only 1 table in memory
  BREAK-POINT.

  READ TABLE lt_tab INDEX 1 ASSIGNING <ls_tab>.
  <ls_tab>-mandt = '123'.
* performance hit! lo_return has a copy of the old table and lt_tab the new
  BREAK-POINT.

  CLEAR lt_tab.
  FREE lt_tab.

ENDFORM.

FORM local.

  DATA: lo_return TYPE REF TO zcl_return_test2,
        lt_tab    TYPE zcl_return_test=>ty_table_type.

  FIELD-SYMBOLS: <ls_tab> LIKE LINE OF lt_tab.


  CREATE OBJECT lo_return.

  lt_tab = lo_return->return_local( 200000 ).
* only 1 table in memory
  BREAK-POINT.

  READ TABLE lt_tab INDEX 1 ASSIGNING <ls_tab>.
  <ls_tab>-mandt = '123'.
* table is not copied, still 1 table in memory
  BREAK-POINT.

  CLEAR lt_tab.
  FREE lt_tab.

ENDFORM.
