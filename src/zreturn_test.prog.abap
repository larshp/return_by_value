*&---------------------------------------------------------------------*
*& Report ZRETURN_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zreturn_test.

PARAMETERS: p_count TYPE i OBLIGATORY DEFAULT 1000000.

START-OF-SELECTION.
  PERFORM run.

FORM run.

  DEFINE _start.
    CLEAR lt_tab.
    GET RUN TIME FIELD t1.
  END-OF-DEFINITION.

  DEFINE _stop.
    GET RUN TIME FIELD t2.
    elapsed = ( t2 - t1  ) / 1000000.
    WRITE: / elapsed, 'seconds,', &1.
  END-OF-DEFINITION.

  DATA: lo_return TYPE REF TO zcl_return_test,
        lt_tab    TYPE integer_tab2,
        t1        TYPE i,
        t2        TYPE i,
        elapsed   TYPE i.


  CREATE OBJECT lo_return.

  DO 10 TIMES.
    _start.
    lt_tab = lo_return->return_by_value( p_count ).
    WRITE: / lines( lt_tab ).
    _stop 'return'.

    _start.
    lo_return->exporting( EXPORTING iv_count = p_count
                          IMPORTING et_values = lt_tab ).
    WRITE: / lines( lt_tab ).
    _stop 'exporting'.
  ENDDO.


  WRITE: / 'Done'.

ENDFORM.
