FUNCTION zmhp_kapatool_get_ddb_kostl.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_RESULT) TYPE  OBJEC_T
*"----------------------------------------------------------------------



  " Plan: OO-DOWN + eigene OE, Kostl ermitteln

  DATA: lv_usrid      TYPE p0105-usrid,
        lv_pernr      TYPE p0105-pernr,
        lt_p0001      TYPE p0001_tab,
        ls_p0001      TYPE p0001,
        lt_result     TYPE TABLE OF swhactor,
        ls_result     TYPE swhactor,
        lv_plvar      TYPE plvar,
        ls_objec      LIKE LINE OF et_result,
        ls_cskt       TYPE cskt,
        lv_kostl_1001 TYPE sobid.

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

        SORT lt_result BY objid ASCENDING.
        DELETE ADJACENT DUPLICATES FROM lt_result.

        LOOP AT lt_result INTO ls_result
        WHERE otype = 'O'.

          SELECT SINGLE sobid FROM hrp1001 INTO lv_kostl_1001
          WHERE begda <= sy-datum
          AND endda >= sy-datum
          AND objid = ls_result-objid
          AND otype = 'O'
          AND plvar = lv_plvar.

          IF sy-subrc = 0.

            " **************** 2 DO **********
            " BERECHTIGUNGSPRÜFUNG OB PERSON KOSTL SEHEN DARF

            SELECT SINGLE * FROM cskt INTO ls_cskt
            WHERE kostl = lv_kostl_1001
            AND spras = sy-langu
            AND datbi >= sy-datum.

            IF sy-subrc = 0.
              ls_objec-objid = lv_kostl_1001.
              ls_objec-short = ls_cskt-ktext.
              ls_objec-stext = ls_cskt-ltext.
              APPEND ls_objec TO et_result.
            ELSE.
              ls_objec-objid = '00000000'.
              ls_objec-short = ''. "'Keine KOSTL gefunden.'.
              ls_objec-stext = ''. "'Keine KOSTL gefunden.'.
              APPEND ls_objec TO et_result.
            ENDIF.

          ENDIF.

          CLEAR: ls_result, lv_kostl_1001, ls_objec, ls_cskt.
        ENDLOOP.

      ELSE.
        ls_result-objid = ls_p0001-orgeh.
        ls_result-otype = 'O'.
        APPEND ls_result TO lt_result.
      ENDIF.
    ENDIF.
  ENDIF.

  SORT et_result BY objid ASCENDING.
  DELETE ADJACENT DUPLICATES FROM et_result.

ENDFUNCTION.
