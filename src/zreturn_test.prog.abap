REPORT zreturn_test.
* quick and dirty test code

PARAMETERS: p_rows   TYPE i OBLIGATORY DEFAULT 1000000,
            p_times  TYPE i OBLIGATORY DEFAULT 100,
            p_detail TYPE c AS CHECKBOX.


START-OF-SELECTION.
  PERFORM run.

FORM run.

  DEFINE _start.
    CLEAR lt_tab.
    FREE lt_tab.
    GET RUN TIME FIELD t1.
  END-OF-DEFINITION.

  DEFINE _stop.
    GET RUN TIME FIELD t2.
    elapsed = ( t2 - t1 ).
    IF p_detail = abap_true.
      WRITE: / elapsed, 'microseconds,', &1.
    ENDIF.
    CLEAR lt_tab.
    FREE lt_tab.
  END-OF-DEFINITION.

  DATA: lo_return TYPE REF TO zcl_return_test,
        lt_tab    TYPE zcl_return_test=>ty_table_type,
        lt_tab2   TYPE zcl_return_test=>ty_table_type,
        lv_lines  TYPE c LENGTH 20,
        exporting TYPE i,
        returning TYPE i,
        t1        TYPE i,
        t2        TYPE i,
        elapsed   TYPE i.


  CREATE OBJECT lo_return EXPORTING iv_rows = p_rows.
  WRITE: / p_rows, 'rows'.
  WRITE: / p_times, 'times'.
  WRITE: /.

  DO p_times TIMES.
    _start.
    lt_tab = lo_return->return_by_value( ).
    lv_lines = lines( lt_tab ).
    _stop 'return'.
    returning = returning + elapsed.

    _start.
    lo_return->exporting( IMPORTING et_values = lt_tab ).
    lv_lines = lines( lt_tab ).
    _stop 'exporting'.
    exporting = exporting + elapsed.
  ENDDO.

  WRITE: /.

* averages
  returning = returning / p_times.
  WRITE: / 'Returning:', returning, 'microseconds average'.
  exporting = exporting / p_times.
  WRITE: / 'Exporting:', exporting, 'microseconds average'.

ENDFORM.
