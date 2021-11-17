FUNCTION zmhp_kapatool_get_data_graphic.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_ORGEH) TYPE  ORGEH OPTIONAL
*"  EXPORTING
*"     VALUE(ET_TABLE) TYPE  ZCL_ZMHP_KAPAZITAETSPL_MPC=>TT_FORECAST
*"----------------------------------------------------------------------


  DATA: ls_forecast    TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast,
        lv_true        TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast-islink,
        lv_false       TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast-islink,
        lv_success     TYPE flag,
        ls_wconfig     TYPE zmhp_kapatool_wc,
        lv_usrid       TYPE p0105-usrid,
        lv_pernr       TYPE p0105-pernr,
        lv_tabix       LIKE sy-tabix,
        lt_tab_months  TYPE zmhp_kapatool_t_month,
        ls_tab_month   TYPE zmhp_kapatool_s_month,
        lt_kpi         TYPE TABLE OF zmhp_kapatool_kp,
        ls_kpi         TYPE zmhp_kapatool_kp,
        lv_short       TYPE short_d,
        lv_stext       TYPE stext,
        lv_counter     TYPE orgeh,
        lv_counter_str TYPE string,
        lv_value_str   TYPE string,
        lv_value_str1  TYPE string,
        lv_value_str2  TYPE string,
        lv_length      TYPE i.

  FIELD-SYMBOLS: <lfs_month>      TYPE zmhp_kapatool_s_month,
                 <lfs_monatstext> TYPE any.

  REFRESH: et_table, gt_vsi_cum, gt_vsi.
  CLEAR: gv_sum_bedarf,
      gv_sum_bedarf_dir,
      gv_sum_bedarf_ang,
      gv_sum_bedarf_gew,
      gv_sum_bedarf_gew_ind,
      gv_sum_bedarf_gew_dir,
      gv_sum_vsi,
      gv_sum_vsi_ang,
      gv_sum_vsi_gew,
      gv_sum_vsi_gew_ind,
      gv_sum_vsi_gew_dir,
      gv_sum_soll,
      gv_sum_plan,
      gv_sum_plan_ang,
      gv_sum_plan_gew.

  lv_true = abap_true.
  lv_false = abap_false.
  lv_counter = 00000001.


* Getting KPI Table
  SELECT * FROM zmhp_kapatool_kp INTO TABLE lt_kpi
    WHERE bukrs = '0001'
    AND   kpi_for_graphic = 'X'.

* Getting Table Configuration
  CALL FUNCTION 'ZMHP_KAPATOOL_GET_TAB_WCONFIG'
    IMPORTING
      es_zmhp_kapatool_wconfig = ls_wconfig
      ev_success               = lv_success.

  " if IV_ORGEH is not initial, dann ist es ein Call vom Orgeh-Dropdown, d.h. lesen für die ORGEH
  " ansonsten wird die ORGEH genommen welche eh schon in WCONFIG steht (sprich die oberste)
  IF iv_orgeh IS NOT INITIAL.
    ls_wconfig-orgeh = iv_orgeh.
  ENDIF.

  IF lv_success IS NOT INITIAL.

    " Getting selected orgunit
    CLEAR: lv_short, lv_stext, lv_length.
    SELECT SINGLE short stext FROM hrp1000 INTO (lv_short, lv_stext)
      WHERE objid = ls_wconfig-orgeh
      AND   otype = 'O'
      AND   begda <= sy-datum
      AND   endda >= sy-datum.
    lv_length = strlen( lv_short ).

    " Getting Months
    CALL FUNCTION 'ZMHP_KAPATOOL_GET_TAB_MONTHS'
      EXPORTING
        iv_begda      = ls_wconfig-begda
        iv_endda      = ls_wconfig-endda
        iv_gj         = ls_wconfig-gj_display
      IMPORTING
        et_tab_months = lt_tab_months.

*    CASE ls_wconfig-cumulative.
*
*      WHEN abap_true.
*
*      WHEN abap_false.

    LOOP AT lt_tab_months ASSIGNING <lfs_month>. "Voraussetzung: 1. Zeile = 1. Monat, 2. Zeile = 2. Monat etc.

      ls_forecast-forecastid = lv_counter.
      ls_forecast-editable = abap_false.
      ls_forecast-title = <lfs_month>-montxt.

      REFRESH: gt_vsi_cum, gt_vsi.
      CLEAR: gv_sum_bedarf,
      gv_sum_bedarf_dir,
      gv_sum_bedarf_ang,
      gv_sum_bedarf_gew,
      gv_sum_bedarf_gew_ind,
      gv_sum_bedarf_gew_dir,
      gv_sum_vsi,
      gv_sum_vsi_ang,
      gv_sum_vsi_gew,
      gv_sum_vsi_gew_ind,
      gv_sum_vsi_gew_dir,
      gv_sum_soll,
      gv_sum_plan,
      gv_sum_plan_ang,
      gv_sum_plan_gew.

      lv_tabix = 6.
      LOOP AT lt_kpi INTO ls_kpi.

        lv_tabix = lv_tabix + 1.
        ASSIGN COMPONENT lv_tabix OF STRUCTURE ls_forecast TO <lfs_monatstext>.
        PERFORM get_kpi_value USING ls_wconfig-orgeh
                                    lv_short
                                    lv_length
                                    ls_wconfig-cumulative
                                    ls_kpi-kpi_id
                                    <lfs_month>-montxt
                                    ls_wconfig-gj_display
                                    ls_wconfig-bukrs
                                    ls_wconfig-location
                                    ls_wconfig-kostl
                              CHANGING <lfs_monatstext>
*                                    ls_wconfig-value
*                                    ls_wconfig-title
                                    ls_kpi-kpi_txt.


        " nur temporär, da Grafiken aktuell keine Kommastellen darstellen können.
        lv_value_str = <lfs_monatstext>.
*        REPLACE ',' in lv_value_str1 WITH '.'.
        SPLIT lv_value_str AT ',' INTO lv_value_str1 lv_value_str2.
        MOVE lv_value_str1 TO <lfs_monatstext>.


        CLEAR: ls_kpi, lv_value_str, lv_value_str1, lv_value_str2.
      ENDLOOP.

      APPEND ls_forecast TO et_table.
      lv_counter = lv_counter + 1.
      CLEAR: ls_tab_month, ls_forecast.
    ENDLOOP.


*    ENDCASE.
  ENDIF. " success not initial

ENDFUNCTION.
