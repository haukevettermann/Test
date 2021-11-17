FUNCTION zmhp_kapatool_get_ddb_orgeh.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(ET_RESULT) TYPE  OBJEC_T
*"----------------------------------------------------------------------

  DATA: lv_usrid      TYPE p0105-usrid,
        lv_pernr      TYPE p0105-pernr,
        lt_p0001      TYPE p0001_tab,
        ls_p0001      TYPE p0001,
        lt_result     TYPE TABLE OF swhactor,
        ls_result     TYPE swhactor,
        lv_plvar      TYPE plvar,
        ls_objec      LIKE LINE OF et_result,
        ls_cskt       TYPE cskt,
        lv_kostl_1001 TYPE sobid,
        ls_hrp1000    TYPE hrp1000,
        lt_hrp1000    TYPE TABLE OF hrp1000.

  CALL FUNCTION 'RH_GET_ACTIVE_WF_PLVAR'
    IMPORTING
      act_plvar       = lv_plvar
    EXCEPTIONS
      no_active_plvar = 1
      OTHERS          = 2.

  IF sy-subrc <> 0.
    lv_plvar = '01'.
  ENDIF.

  MOVE sy-uname TO lv_usrid.
  CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
    EXPORTING
      begda     = sy-datum
      endda     = sy-datum
      usrid     = lv_usrid
      usrty     = '0001'
    IMPORTING
      usr_pernr = lv_pernr
    EXCEPTIONS
      retcd     = 1
      OTHERS    = 2.

  IF sy-subrc = 0.
    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = lv_pernr
        infty           = '0001'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0001
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.

    SORT lt_p0001 BY endda DESCENDING begda DESCENDING.
    READ TABLE lt_p0001 INTO ls_p0001 INDEX 1.
    REFRESH lt_p0001.

    IF sy-subrc = 0.
      CALL FUNCTION 'RH_STRUC_GET'
        EXPORTING
          act_otype       = 'O'
          act_objid       = ls_p0001-orgeh
          act_wegid       = 'O-O_DOWN'
*         ACT_INT_FLAG    =
          act_begda       = sy-datum
          act_endda       = sy-datum
          act_tdepth      = 0
*         ACT_TFLAG       = 'X'
*         ACT_VFLAG       = 'X'
          authority_check = 'X'
        TABLES
          result_tab      = lt_result
*         RESULT_OBJEC    =
*         RESULT_STRUC    =
        EXCEPTIONS
          no_plvar_found  = 1
          no_entry_found  = 2
          OTHERS          = 3.

      IF sy-subrc = 0.

        ls_result-objid = ls_p0001-orgeh.
        ls_result-otype = 'O'.
        APPEND ls_result TO lt_result.

        LOOP AT lt_result INTO ls_result.
          SELECT SINGLE * FROM hrp1000 INTO ls_hrp1000
          WHERE begda <= sy-datum
          AND endda >= sy-datum
          AND objid = ls_result-objid
          AND otype = 'O'
          AND plvar = lv_plvar.

          ls_objec-objid = ls_result-objid.
          ls_objec-short = ls_hrp1000-short.
          ls_objec-stext = ls_hrp1000-stext.
          ls_objec-otype = 'O'.

          APPEND ls_objec TO et_result.
          CLEAR: ls_result, ls_hrp1000.
        ENDLOOP.

      ELSE.
        CLEAR: ls_hrp1000.
        SELECT SINGLE * FROM hrp1000 INTO ls_hrp1000
        WHERE begda <= sy-datum
        AND endda >= sy-datum
        AND objid = ls_p0001-orgeh
        AND otype = 'O'
        AND plvar = lv_plvar.

        ls_objec-objid = ls_p0001-orgeh.
        ls_objec-short = ls_hrp1000-short.
        ls_objec-stext = ls_hrp1000-stext.
        ls_objec-otype = 'O'.
        APPEND ls_objec TO et_result.
      ENDIF.
    ENDIF.
  ENDIF.

  SORT et_result BY objid ASCENDING.
  DELETE ADJACENT DUPLICATES FROM et_result.



*  DATA: lv_plvar   TYPE plvar,
*        lt_result  TYPE objec_t,
*        ls_result  TYPE objec,
*        lv_success TYPE flag,
*        ls_wconfig TYPE zhr06_wconfig,
*        lv_orgeh   TYPE orgeh.
*
**  CALL FUNCTION 'ZHR06_GET_TAB_WCONFIG'
**    IMPORTING
**      es_zhr06_wconfig = ls_wconfig
**      ev_success       = lv_success.
**
**  IF lv_success IS NOT INITIAL.
*
*  CALL FUNCTION 'RH_GET_ACTIVE_WF_PLVAR'
*    IMPORTING
*      act_plvar       = lv_plvar
*    EXCEPTIONS
*      no_active_plvar = 1
*      OTHERS          = 2.
*
**    MOVE ls_wconfig-orgeh TO lv_orgeh.
*
*  MOVE '50000075' TO lv_orgeh.
*
*  CALL FUNCTION 'RH_STRUC_GET'
*    EXPORTING
*      act_otype       = 'O'
*      act_objid       = lv_orgeh
*      act_wegid       = 'O-O_DOWN'
*      act_plvar       = lv_plvar
*      act_begda       = sy-datum
*      act_endda       = sy-datum
**     act_tdepth      = 3
*      authority_check = ''
*    TABLES
**     RESULT_TAB      =
*      result_objec    = lt_result
**     RESULT_STRUC    =
*    EXCEPTIONS
*      no_plvar_found  = 1
*      no_entry_found  = 2
*      OTHERS          = 3.
*
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ELSE.
*    MOVE lt_result TO et_result.
*    REFRESH: lt_result.
*  ENDIF.
*
**  ENDIF.

ENDFUNCTION.
