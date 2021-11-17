FUNCTION zmhp_kapatool_get_data_table.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_PERNR) TYPE  PERNR_D
*"     VALUE(IV_BEGDA) TYPE  BEGDA
*"     VALUE(IV_ENDDA) TYPE  ENDDA
*"     VALUE(IV_CUMULATIVE) TYPE  FLAG OPTIONAL
*"     VALUE(IV_ORGEH) TYPE  ORGEH OPTIONAL
*"     VALUE(IV_BUKRS) TYPE  BUKRS OPTIONAL
*"     VALUE(IV_LOCATION) TYPE  STRING OPTIONAL
*"     VALUE(IV_KOSTL) TYPE  KOSTL OPTIONAL
*"  EXPORTING
*"     VALUE(ET_TABLE) TYPE  ZCL_ZMHP_KAPAZITAETSPL_MPC=>TT_FORECAST
*"----------------------------------------------------------------------


  DATA: ls_forecast   TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast,
        ls_forecast_2 TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast,
        lv_true       TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast-islink,
        lv_false      TYPE zcl_zmhp_kapazitaetspl_mpc=>ts_forecast-islink,
        ls_wconfig    TYPE zmhp_kapatool_wc,
        lv_success    TYPE flag,
        lv_usrid      TYPE p0105-usrid,
        lv_pernr      TYPE p0105-pernr,
        lv_tabix      LIKE sy-tabix,
        lt_tab_months TYPE zmhp_kapatool_t_month,
        lt_kpi        TYPE TABLE OF zmhp_kapatool_kp,
        ls_kpi        TYPE zmhp_kapatool_kp,
        lv_temp       TYPE string,
        lv_temp_date  TYPE char10,
        lv_begda      TYPE char10,
        lv_count      TYPE i,
        lv_short      TYPE short_d,
        lv_stext      TYPE stext,
        lv_modify     TYPE wdy_boolean,
        lv_index      TYPE sy-tabix,
        lv_length     TYPE i.

  FIELD-SYMBOLS: <lfs_month>      TYPE zmhp_kapatool_s_month,
                 <lfs_monatstext> TYPE any.

* Initialization
  REFRESH: et_table, gt_vsi_cum, gt_vsi.
  CLEAR:  gv_sum_bedarf,
          gv_sum_bedarf_dir,
          gv_sum_bedarf_ang,
          gv_sum_bedarf_gew,
          gv_sum_bedarf_gew_ind,
          gv_sum_bedarf_gew_dir,
          gv_sum_max_gen_kapa,
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

* PLVAR
  CALL FUNCTION 'RH_GET_ACTIVE_WF_PLVAR'
    IMPORTING
      act_plvar       = gv_plvar
    EXCEPTIONS
      no_active_plvar = 1
      OTHERS          = 2.

  IF sy-subrc <> 0.
    gv_plvar = '01'.
  ENDIF.

* Getting KPI Table
  IF iv_bukrs IS NOT INITIAL.
    SELECT * FROM zmhp_kapatool_kp INTO TABLE lt_kpi
      WHERE bukrs = iv_bukrs.
  ELSE.
    SELECT * FROM zmhp_kapatool_kp INTO TABLE lt_kpi
      WHERE bukrs = '0001'.
  ENDIF.

  " Fallback M76 - MHP
  IF lt_kpi IS INITIAL.
    SELECT * FROM zmhp_kapatool_kp INTO TABLE lt_kpi
      WHERE bukrs = '0001'.
  ENDIF.

  " Sortierung der KPIs
  SORT lt_kpi BY reihenfolge ASCENDING.

** Getting Table Configuration
*  CALL FUNCTION 'ZMHP_GET_CONF_WEBCONFIG'
*    IMPORTING
*      es_zmhp_kapatool_wconfig = ls_wconfig
*      ev_success       = lv_success.

  ls_wconfig-begda = iv_begda.
  ls_wconfig-endda = iv_endda.
  ls_wconfig-orgeh = iv_orgeh.
  ls_wconfig-cumulative = iv_cumulative.
  ls_wconfig-bukrs = iv_bukrs.
  ls_wconfig-location = iv_location.
  ls_wconfig-kostl = iv_kostl.
  ls_wconfig-pernr = iv_pernr.
  lv_success = abap_true.

  IF lv_success IS NOT INITIAL.

    " Org.-Unit Texte
    CLEAR: lv_short, lv_stext, lv_length.

    SELECT SINGLE short stext FROM hrp1000 INTO (lv_short, lv_stext)
    WHERE objid = ls_wconfig-orgeh
    AND   otype = 'O'
    AND   begda <= sy-datum
    AND   endda >= sy-datum.

    lv_length = strlen( lv_short ).

    " Monate ermitteln
    CALL FUNCTION 'ZMHP_KAPATOOL_GET_CONF_MONTHS'
      EXPORTING
        iv_begda      = ls_wconfig-begda
        iv_endda      = ls_wconfig-endda
      IMPORTING
        et_tab_months = lt_tab_months.

    LOOP AT lt_tab_months ASSIGNING <lfs_month>.

      CLEAR lv_tabix.
      lv_tabix = sy-tabix + 6.
      ASSIGN COMPONENT lv_tabix OF STRUCTURE ls_forecast TO <lfs_monatstext>.

      " Global Initialization
      REFRESH: gt_vsi,
               gt_vsi_cum,
               gt_vsi_cum_vormonat,
               gt_vsi_vormonat,
               gt_comparison.         " !

      CLEAR:  gv_sum_bedarf,
              gv_sum_bedarf_dir,
              gv_sum_bedarf_ang,
              gv_sum_bedarf_gew,
              gv_sum_bedarf_gew_ind,
              gv_sum_bedarf_gew_dir,
              gv_sum_max_gen_kapa,    " !
              gv_sum_vsi,
              gv_sum_vsi_ang,
              gv_sum_vsi_gew,
              gv_sum_vsi_gew_ind,
              gv_sum_vsi_gew_dir,
              gv_sum_soll,
              gv_sum_plan,
              gv_sum_plan_ang,
              gv_sum_plan_gew.

      LOOP AT lt_kpi INTO ls_kpi.

        " Move-Corresponding Aktionen
        MOVE ls_kpi-kpi_id TO ls_forecast-forecastid.
        MOVE ls_kpi-kpi_longtext TO ls_forecast-kpilongtext.
        MOVE ls_kpi-kpi_tooltip TO ls_forecast-tooltip.

        CLEAR: ls_forecast_2.
        lv_modify = abap_false.
        READ TABLE et_table INTO ls_forecast_2 WITH KEY forecastid = ls_forecast-forecastid.
        IF sy-subrc = 0.
          lv_index = sy-tabix.
          MOVE-CORRESPONDING ls_forecast_2 TO ls_forecast.
          lv_modify = abap_true.
        ENDIF.

        MOVE ls_kpi-parent_id TO ls_forecast-parentid.
        MOVE ls_kpi-kpi_txt TO ls_forecast-title.

        " Design und Semantic Color
        " Auswahl Fontclass:        ||  Auswahl Class:
        " - Critical (alarm-rot)    ||  - Bold (fett) // Italic (kursiv) // Underline (unterstrichen)
        " - Default (schwarz)       ||  - H1 .. H6 (headlines, 6 ist kleinste)
        " - Negative (rot)          ||  - Monospace (weiss nicht)
        " - Positive (grün)         ||  - Small (klein)
        "                           ||  - Standard (normal)

        IF ls_kpi-design EQ 'NORMAL'.
          ls_forecast-fontclass = 'Default'.
          ls_forecast-class = 'Standard'.
        ELSEIF ls_kpi-design EQ 'BOLD'.
          ls_forecast-fontclass = 'Default'.
          ls_forecast-class = 'Bold'.
        ELSEIF ls_kpi-design EQ 'COLOR'.
          ls_forecast-fontclass = 'Positive'.
          ls_forecast-class = 'Standard'.
        ELSEIF ls_kpi-design EQ 'BOLD_COLOR'.
          ls_forecast-fontclass = 'Positive'.
          ls_forecast-class = 'Bold'.
        ENDIF.

        " Darstellungstyp setzen
        IF ls_kpi-type EQ 'LINK'.
          ls_forecast-editable = abap_false.
          ls_forecast-istext = abap_false.
          ls_forecast-islink = abap_true.
        ELSEIF ls_kpi-type EQ 'INPUT'.
          ls_forecast-editable = abap_true.
          ls_forecast-istext = abap_false.
          ls_forecast-islink = abap_false.
        ELSEIF ls_kpi-type EQ 'TEXT'.
          ls_forecast-editable = abap_false.
          ls_forecast-istext = abap_true.
          ls_forecast-islink = abap_false.
        ELSE.
          " used for hiding KPIs
          CONTINUE.
        ENDIF.

        " KPI Ermittlung
        IF ls_kpi-kpi_id = 1.

          <lfs_monatstext> = <lfs_month>-montxt.
          IF ls_wconfig-cumulative EQ abap_true.
            CONCATENATE 'selektierte Abteilung:' lv_short 'inkl. Unterstruktur' INTO ls_forecast-title SEPARATED BY space.
          ELSE.
            CONCATENATE 'selektierte Abteilung:' lv_short INTO ls_forecast-title SEPARATED BY space.
          ENDIF.

        ELSE.

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
                                      ls_kpi-kpi_txt.

          " TOOLTIPS !!
          MOVE ls_kpi-kpi_longtext TO ls_forecast-kpilongtext.
          MOVE ls_kpi-kpi_tooltip TO ls_forecast-tooltip.

        ENDIF.

        IF ls_kpi-ressort EQ 'X'
                  AND lv_length = 1.
          IF lv_modify = abap_true.
*            MODIFY et_table FROM ls_forecast INDEX lv_index.
          ELSE.
*            APPEND ls_forecast TO et_table.
          ENDIF.
        ELSEIF ls_kpi-ressort NE 'X'.
          IF lv_modify = abap_true.
            MODIFY et_table FROM ls_forecast INDEX lv_index.
          ELSE.
            APPEND ls_forecast TO et_table.
          ENDIF.
        ENDIF.

        CLEAR: ls_forecast, ls_kpi.
      ENDLOOP.
    ENDLOOP.

  ENDIF. " wconfig not initial

ENDFUNCTION.
