FUNCTION zmhp_kapatool_get_ddb_loc.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(ET_RESULT) TYPE  OBJEC_T
*"----------------------------------------------------------------------

  DATA: ls_result LIKE LINE OF et_result.

  " Stammhaus
  ls_result-objid = '99999999'.
  ls_result-otype = 'ZS'.

  ls_result-short = 'Stammhaus'. "cl_wd_utilities=>get_otr_text_by_alias(
  "alias = 'ZHR06/ZHR06_STANDORT_STAMMHAUS'
  "language = sy-langu ).

  ls_result-stext = 'Stammhaus'. "cl_wd_utilities=>get_otr_text_by_alias(
  "alias = 'ZHR06/ZHR06_STANDORT_STAMMHAUS'
  "language = sy-langu ).

  APPEND ls_result TO et_result.
  CLEAR: ls_result.

ENDFUNCTION.
