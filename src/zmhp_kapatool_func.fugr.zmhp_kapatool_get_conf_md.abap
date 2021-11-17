FUNCTION zmhp_kapatool_get_conf_md.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ES_MASTERDATA) TYPE
*"        ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_MASTERDATA
*"----------------------------------------------------------------------

  DATA: lv_plvar  TYPE plvar,
        lt_result TYPE objec_t,
        ls_result TYPE objec,
        lv_pernr  TYPE p0105-pernr,
        lv_usrid  TYPE p0105-usrid,
        lt_p0001  TYPE p0001_tab,
        ls_p0001  TYPE p0001,
        lv_orgeh  TYPE orgeh,
        lv_short  TYPE short_d,
        lv_long   TYPE stext.

  es_masterdata-masterdataid = 1.

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

  IF lv_pernr IS NOT INITIAL.

    MOVE lv_pernr TO es_masterdata-userpernr.
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

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      SORT lt_p0001 BY endda DESCENDING begda DESCENDING.
      READ TABLE lt_p0001 INTO ls_p0001 INDEX 1.

      MOVE ls_p0001-ename TO es_masterdata-username.

      CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
        EXPORTING
          im_plvar = '01'
          im_otype = 'O'
          im_objid = ls_p0001-orgeh
          im_begda = sy-datum
          im_endda = sy-datum
        IMPORTING
          short    = lv_short.

      es_masterdata-userorgunit = lv_short.

    ENDIF.

    " Rollenprüfung - anhand Berechtigungen (2 do)
    " Mögliche Rollen: Personalreferent (PR), Personalcontroller (PC), IT/HR-Admin (AD), Führungskraft (FK), Sonder HR (SH)
    es_masterdata-userrole = 'PC'.
    es_masterdata-userlanguage = 'en-US'.

  ENDIF.

ENDFUNCTION.
