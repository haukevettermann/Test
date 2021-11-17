FUNCTION zmhp_kapatool_get_conf_wc.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_PERNR) TYPE  PERNR_D OPTIONAL
*"  EXPORTING
*"     VALUE(ES_ZMHP_KAPATOOL_WCONFIG) TYPE  ZMHP_KAPATOOL_WC
*"     VALUE(EV_SUCCESS) TYPE  FLAG
*"----------------------------------------------------------------------

  DATA: lv_plvar   TYPE plvar,
        lt_result  TYPE objec_t,
        ls_result  TYPE objec,
        lv_pernr   TYPE p0105-pernr,
        lv_usrid   TYPE p0105-usrid,
        lv_success TYPE flag,
        ls_wconfig TYPE zmhp_kapatool_wc,
        lv_orgeh   TYPE orgeh.

  IF iv_pernr IS INITIAL.

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

      SELECT SINGLE * FROM zmhp_kapatool_wc
            INTO CORRESPONDING FIELDS OF es_zmhp_kapatool_wconfig
           WHERE pernr EQ lv_pernr.

    ELSE.

      SELECT SINGLE * FROM zmhp_kapatool_wc
            INTO CORRESPONDING FIELDS OF es_zmhp_kapatool_wconfig
           WHERE pernr EQ iv_pernr.

    ENDIF.

  ENDIF.

  IF es_zmhp_kapatool_wconfig IS NOT INITIAL.
    ev_success = 'X'.
  ENDIF.

ENDFUNCTION.
