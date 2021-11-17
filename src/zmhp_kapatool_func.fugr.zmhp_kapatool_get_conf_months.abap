FUNCTION ZMHP_KAPATOOL_GET_CONF_MONTHS.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_BEGDA) TYPE  BEGDA
*"     VALUE(IV_ENDDA) TYPE  ENDDA
*"     VALUE(IV_GJ) TYPE  FLAG OPTIONAL
*"  EXPORTING
*"     VALUE(ET_TAB_MONTHS) TYPE  ZMHP_KAPATOOL_T_MONTH
*"----------------------------------------------------------------------
DATA: ls_tab_months TYPE zmhp_kapatool_s_month,
        lv_startnr    TYPE num,
        lv_endda_txt  TYPE string.

  "letzten Monatstext (Endmonat) merken
  CONCATENATE iv_endda+4(2) '/' iv_endda(4)
  INTO lv_endda_txt.
  "Beginn laufende Nummer bei 1
  lv_startnr = 1.

  IF iv_gj = 'X'.

    WHILE ls_tab_months-montxt NE lv_endda_txt.

      ls_tab_months-nr = lv_startnr.
      iv_begda+4(2) = '12'.
      CONCATENATE iv_begda+4(2) '/' iv_begda(4)
      INTO ls_tab_months-montxt.

      APPEND ls_tab_months TO et_tab_months.

      "Für nächsten Schleifendurchlauf erhöhen...
      ADD 1 TO lv_startnr.
      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
        EXPORTING
          date      = iv_begda
          days      = '0'
          months    = '12'
          signum    = '+'
          years     = '0'
        IMPORTING
          calc_date = iv_begda.
    ENDWHILE.

  ELSE.

    WHILE ls_tab_months-montxt NE lv_endda_txt.

      ls_tab_months-nr = lv_startnr.
      CONCATENATE iv_begda+4(2) '/' iv_begda(4)
      INTO ls_tab_months-montxt.

      APPEND ls_tab_months TO et_tab_months.

      "Für nächsten Schleifendurchlauf erhöhen...
      ADD 1 TO lv_startnr.
      CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
        EXPORTING
          date      = iv_begda
          days      = '0'
          months    = '1'
          signum    = '+'
          years     = '0'
        IMPORTING
          calc_date = iv_begda.
    ENDWHILE.
  ENDIF.




ENDFUNCTION.
