CLASS zcl_return_test DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_table_type TYPE STANDARD TABLE OF usr02 WITH DEFAULT KEY.

    METHODS exporting
      IMPORTING
        !iv_count        TYPE i
      EXPORTING
        VALUE(et_values) TYPE ty_table_type .
    METHODS return_by_value
      IMPORTING
        !iv_count        TYPE i
      RETURNING
        VALUE(rt_values) TYPE ty_table_type .
protected section.
private section.
ENDCLASS.



CLASS ZCL_RETURN_TEST IMPLEMENTATION.


  METHOD exporting.

    FIELD-SYMBOLS: <ls_value> LIKE LINE OF et_values.

    DO iv_count TIMES.
      APPEND INITIAL LINE TO et_values ASSIGNING <ls_value>.
      <ls_value>-bname = sy-index.
    ENDDO.

  ENDMETHOD.


  METHOD return_by_value.

    FIELD-SYMBOLS: <ls_value> LIKE LINE OF rt_values.

    DO iv_count TIMES.
      APPEND INITIAL LINE TO rt_values ASSIGNING <ls_value>.
      <ls_value>-bname = sy-index.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
