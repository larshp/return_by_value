class ZCL_RETURN_TEST definition
  public
  create public .

public section.

  types:
    ty_table_type TYPE STANDARD TABLE OF usr02 WITH DEFAULT KEY .

  methods EXPORTING
    importing
      !IV_ROWS type I
    exporting
      value(ET_VALUES) type TY_TABLE_TYPE .
  methods RETURN_BY_VALUE
    importing
      !IV_ROWS type I
    returning
      value(RT_VALUES) type TY_TABLE_TYPE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_RETURN_TEST IMPLEMENTATION.


  METHOD exporting.

    FIELD-SYMBOLS: <ls_value> LIKE LINE OF et_values.

    DO iv_rows TIMES.
      APPEND INITIAL LINE TO et_values ASSIGNING <ls_value>.
      <ls_value>-bname = sy-index.
    ENDDO.

  ENDMETHOD.


  METHOD return_by_value.

    FIELD-SYMBOLS: <ls_value> LIKE LINE OF rt_values.

    DO iv_rows TIMES.
      APPEND INITIAL LINE TO rt_values ASSIGNING <ls_value>.
      <ls_value>-bname = sy-index.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
