class ZCL_RETURN_TEST definition
  public
  create public .

public section.

  methods EXPORTING
    importing
      !IV_COUNT type I
    exporting
      value(ET_VALUES) type INTEGER_TAB2 .
  methods RETURN_BY_VALUE
    importing
      !IV_COUNT type I
    returning
      value(RT_VALUES) type INTEGER_TAB2 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_RETURN_TEST IMPLEMENTATION.


  METHOD exporting.

    DO iv_count TIMES.
      APPEND sy-index TO et_values.
    ENDDO.

  ENDMETHOD.


  METHOD RETURN_BY_VALUE.

    DO iv_count TIMES.
      APPEND sy-index TO rt_values.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
