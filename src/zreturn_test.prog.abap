*&---------------------------------------------------------------------*
*& Report ZRETURN_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zreturn_test.

PARAMETERS: p_count TYPE i OBLIGATORY DEFAULT 1000,
            p_times TYPE i OBLIGATORY DEFAULT 10.

START-OF-SELECTION.
  PERFORM run.

FORM run.

  DEFINE _start.
    CLEAR lt_tab.
    GET RUN TIME FIELD t1.
  END-OF-DEFINITION.

  DEFINE _stop.
    GET RUN TIME FIELD t2.
    elapsed = ( t2 - t1 ).
    WRITE: / elapsed, 'microseconds,', &1.
  END-OF-DEFINITION.

  DATA: lo_return TYPE REF TO zcl_return_test,
        lt_tab    TYPE zcl_return_test=>ty_table_type,
        lv_foo    TYPE c LENGTH 20,
        exporting TYPE i,
        returning TYPE i,
        t1        TYPE i,
        t2        TYPE i,
        elapsed   TYPE i.


  CREATE OBJECT lo_return.
  WRITE: / p_count, 'rows'.
  WRITE: /.

  DO p_times TIMES.
    _start.
    lt_tab = lo_return->return_by_value( p_count ).
    WRITE lines( lt_tab ) TO lv_foo.
    _stop 'return'.
    returning = returning + elapsed.

    _start.
    lo_return->exporting( EXPORTING iv_count = p_count
                          IMPORTING et_values = lt_tab ).
    WRITE lines( lt_tab ) TO lv_foo.
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
