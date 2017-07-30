REPORT zreturn_memory.

START-OF-SELECTION.
  PERFORM run.

FORM run.

  DATA: lt_tab    TYPE zcl_return_test=>ty_table_type,
        lt_tab2   TYPE zcl_return_test=>ty_table_type,
        lo_return TYPE REF TO zcl_return_test.

  FIELD-SYMBOLS: <ls_tab> LIKE LINE OF lt_tab.


  CREATE OBJECT lo_return EXPORTING iv_rows = 500000.
  lt_tab = lo_return->return_by_value( ).

***********

  lt_tab2 = lt_tab.
  BREAK-POINT.

  READ TABLE lt_tab2 INDEX 1 ASSIGNING <ls_tab>.
  <ls_tab>-mandt = '123'.
  BREAK-POINT.

ENDFORM.
