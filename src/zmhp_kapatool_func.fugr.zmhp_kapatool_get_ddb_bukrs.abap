FUNCTION zmhp_kapatool_get_ddb_bukrs.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_RESULT) TYPE  OBJEC_T
*"----------------------------------------------------------------------

  DATA: lt_kpi   TYPE TABLE OF zmhp_kapatool_kp,
        ls_kpi   TYPE zmhp_kapatool_kp,
        ls_t001  TYPE t001,
        ls_objec LIKE LINE OF et_result.

  SELECT bukrs FROM zmhp_kapatool_kp INTO CORRESPONDING FIELDS OF TABLE lt_kpi.
  SORT lt_kpi BY bukrs ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_kpi.

  LOOP AT lt_kpi INTO ls_kpi.
    SELECT SINGLE * FROM t001 INTO ls_t001
    WHERE bukrs EQ ls_kpi-bukrs.

    " **************** 2 DO **********
    " BERECHTIGUNGSPRÜFUNG OB PERSON BUKRS SEHEN DARF

    ls_objec-objid = ls_t001-bukrs.
    ls_objec-short = ls_t001-butxt.
    CONCATENATE ls_t001-butxt '(' INTO ls_objec-stext SEPARATED BY space.
    CONCATENATE ls_objec-stext ls_t001-ort01 ')' INTO ls_objec-stext.
    APPEND ls_objec TO et_result.
    CLEAR: ls_t001, ls_objec.
    CLEAR: ls_kpi, ls_objec, ls_t001.
  ENDLOOP.
ENDFUNCTION.
