*----------------------------------------------------------------------*
***INCLUDE LZMHP_KAPATOOL_FUNCF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_KPI_VALUE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LS_WCONFIG_ORGEH  text
*      -->P_LV_SHORT  text
*      -->P_LV_LENGTH  text
*      -->P_LS_WCONFIG_CUMULATIVE  text
*      -->P_LS_KPI_KPI_ID  text
*      -->P_<LFS_MONTH>_MONTXT  text
*      -->P_LS_WCONFIG_GJ_DISPLAY  text
*      -->P_LS_WCONFIG_BUKRS  text
*      -->P_LS_WCONFIG_LOCATION  text
*      -->P_LS_WCONFIG_KOSTL  text
*      <--P_<LFS_MONATSTEXT>  text
*      <--P_LS_KPI_KPI_TXT  text
*----------------------------------------------------------------------*
FORM get_kpi_value
    USING   p_orgeh TYPE orgeh
            p_short TYPE short_d
            p_length TYPE i
            p_cumulative TYPE flag
            p_kpi_id TYPE hrobjid
            p_monthtxt TYPE string
            p_gj_display TYPE flag
            p_bukrs TYPE bukrs
            p_location TYPE string
            p_kostl TYPE kostl
   CHANGING p_value TYPE string
            p_title TYPE text60.

**********************************************************************
* Data Declaration
  DATA:        lt_orgunits       TYPE TABLE OF swhactor,
               ls_orgunit        TYPE swhactor,
               lt_result         TYPE TABLE OF swhactor,
               ls_result         TYPE swhactor,
               lt_result_objec   TYPE TABLE OF objec,
               ls_result_objec   TYPE objec,
               ls_check_vormonat TYPE zmhp_kapatool_s_kapa,
               ls_kapa           TYPE zmhp_kapatool_s_kapa,
               lv_pernr          TYPE persno,
               lv_switch_leave   TYPE hrpad_leave_switch,
               lv_leavedate      TYPE d,
               lt_leave_dates    TYPE STANDARD TABLE OF hida,
               ls_leave_dates    TYPE hida,
               lv_no_sum         TYPE wdy_boolean,
               lt_p0000          TYPE TABLE OF p0000,
               ls_p0000          TYPE p0000,
               lt_p0001          TYPE TABLE OF p0001,
               ls_p0001          TYPE p0001,
               ls_p0001_old      TYPE p0001,
               lt_p0007          TYPE TABLE OF p0007,
               ls_p0007          TYPE p0007,
               lv_orgeh          TYPE orgeh,
               lv_orgeh_cum      TYPE orgeh,
               lv_date           TYPE dats,
               lv_date_check     TYPE dats,
               lv_value          TYPE string,
               lv_kapa           TYPE zmhp_kapatool_men,
               lv_menge_old      TYPE zmhp_kapatool_men,
               lv_menge          TYPE zmhp_kapatool_men,
               lv_menge_tmp      TYPE zmhp_kapatool_men,
               ls_empl           TYPE zmhp_kapatool_em,
               lv_date_first     TYPE dats,
               lt_persk          TYPE TABLE OF zmhp_kapatool_pe,
               ls_persk          TYPE zmhp_kapatool_pe,
               lv_plans_id       TYPE plog-objid,
               lt_p9922          TYPE TABLE OF p9922,
               ls_p9922          TYPE p9922,
               lv_tdepth         TYPE hrrhas-tdepth,
               ls_basis_std      TYPE zmhp_kapatool_bw,
               ls_comparison     TYPE zmhp_kapatool_s_comp,
               lv_0komma5        TYPE zmhp_kapatool_men,
               lv_temp           TYPE zmhp_kapatool_men.

**********************************************************************
* Setting Date
  IF p_monthtxt(2) = '01'.
    lv_date+6(2) = '31'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = '12'.
    lv_date_check(4) = p_monthtxt+3(4) - 1.

  ELSEIF p_monthtxt(2) = '02'.
    lv_date+6(2) = '28'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '03'.
    lv_date+6(2) = '31'.
    lv_date_check+6(2) = '28'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '04'.
    lv_date+6(2) = '30'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '05'.
    lv_date+6(2) = '31'.
    lv_date_check+6(2) = '30'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '06'.
    lv_date+6(2) = '30'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '07'.
    lv_date+6(2) = '31'.
    lv_date_check+6(2) = '30'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '08'.
    lv_date+6(2) = '31'.
    lv_date_check+6(2) = '30'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '09'.
    lv_date+6(2) = '30'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '10'.
    lv_date+6(2) = '31'.
    lv_date_check+6(2) = '30'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '11'.
    lv_date+6(2) = '30'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = p_monthtxt(2) - 1.
    lv_date_check(4) = p_monthtxt+3(4).

  ELSEIF p_monthtxt(2) = '12'.
    lv_date+6(2) = '31'.
    IF p_gj_display = 'X'. " GJ
      lv_date_check+4(4) = '1231'.
      lv_date_check(4) = p_monthtxt+3(4) - 1.
    ELSE.
      lv_date_check+6(2) = '30'.
      lv_date_check+4(2) = p_monthtxt(2) - 1.
      lv_date_check(4) = p_monthtxt+3(4).
    ENDIF.
  ENDIF.

  lv_date+4(2) = p_monthtxt(2).
  lv_date(4) = p_monthtxt+3(4).
  lv_date_first = lv_date.
  lv_date_first+6(2) = '01'.
  gv_no_one_found = gv_no_one_found2 = gv_no_one_found3 = abap_false.

**********************************************************************
* Get PERSK Customizing
**********************************************************************
  SELECT * FROM zmhp_kapatool_pe INTO TABLE lt_persk.

**********************************************************************
* Determine KPI Value
**********************************************************************

  IF p_kpi_id = 2.

**********************************************************************
* Get Data from Selection (ORGEH, BUKRS, LOCATION)
**********************************************************************
    CALL FUNCTION 'ZHR06_GET_DATA_FROM_SELECTION'
      EXPORTING
        iv_bukrs        = p_bukrs
        iv_costcentre   = p_kostl
        iv_orgeh        = p_orgeh
        iv_location     = p_location
        iv_begda        = lv_date " not date_first -> Stichtagsbezogen, also ENDDA auch BEGDA
        iv_endda        = lv_date
        iv_cumulative   = p_cumulative
        iv_begda_check  = lv_date_check
        iv_endda_check  = lv_date_check
      IMPORTING
        et_vsi          = gt_vsi
        et_vsi_vormonat = gt_vsi_vormonat
        et_comparison   = gt_comparison.

******************************************************************
* Max. genehmigte Kapazität: Org.-Units -> PLANS -> gen. Kapa Feld aus IT 9030

    LOOP AT gt_comparison INTO ls_comparison.

      REPLACE ',' IN ls_comparison-gen_kap WITH '.'.
      ADD ls_comparison-gen_kap TO lv_menge.
      ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.

      CLEAR: ls_comparison.
    ENDLOOP.

  ELSEIF p_kpi_id = 19.
******************************************************************
* IST-Kapazität:
* 1,0 / 100% = Abgleich mit ZHR_BW_ARBZEIT (Wostd.) Feld WoStd enthält die 100% Kapa für den jeweiligen BuKrs

* 2 Do:
* Zur Berechnung soll das Feld PA0007-WOSTD genommen werden

* 2 Do:
* onTop die BündnisStd für den jeweiligen BuKrs aus der Tabelle ZHR_BW_ARBZEIT
* zusätzlicher Abgleich mit Exclude-Tabelle (ZHR_BW_KEIN_BFA)
* [Wostd = ( PA0007-WOSTD / Basis-Stunden )  bei leerem Ergebnis z.B. bei Ministämmen ist es das Feld PA0001-ZHRKAPA]
* Zusätzlich BAV mit einberechnen mit einberechnen (IT2006, Subtyp 90/91) + Weitere anteilige Zeiten (wie bspw. Teilzeit)

    LOOP AT gt_vsi INTO ls_kapa.

      ADD ls_kapa-kapa TO lv_menge.
      ADD ls_kapa-kapa TO gv_sum_vsi.

      CLEAR: ls_kapa.
    ENDLOOP.

    SELECT * FROM zmhp_kapatool_em INTO ls_empl
    WHERE selorgid = p_orgeh
    AND   ( selrowid = '23' OR selrowid = '24' )
    AND   backup02 <= lv_date_first
    AND   backup01 = 'ZUGANG'.

      ADD ls_empl-kapa TO lv_menge.
      ADD ls_empl-kapa TO gv_sum_vsi.
      CLEAR: ls_empl.
    ENDSELECT.

    SELECT * FROM zmhp_kapatool_em INTO ls_empl
    WHERE selorgid = p_orgeh
    AND   ( selrowid = '23' OR selrowid = '24' )
    AND   backup01 = 'ABGANG'
    AND   austrittsdatum <= lv_date_check. " = vorheriges Monatsende

      lv_menge = lv_menge - ls_empl-kapa.
      gv_sum_vsi = gv_sum_vsi - ls_empl-kapa.
      CLEAR: ls_empl.
    ENDSELECT.

  ELSEIF p_kpi_id = 20.
******************************************************************
* IST-Kapa: Zugänge

    LOOP AT gt_vsi INTO ls_kapa.

*      READ TABLE lt_persk
*        WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
*        TRANSPORTING NO FIELDS.
*
*      IF sy-subrc = 0.
        CLEAR: ls_check_vormonat.
        READ TABLE gt_vsi_vormonat INTO ls_check_vormonat
          WITH KEY pernr = ls_kapa-pernr.
        IF sy-subrc NE 0.
          ADD ls_kapa-kapa TO lv_menge.
        ENDIF.
*      ENDIF.
      CLEAR: ls_kapa.

    ENDLOOP.


  ELSEIF p_kpi_id = 21.
******************************************************************
* IST-Kapa: Abgänge

    LOOP AT gt_vsi_vormonat INTO ls_kapa.

*      READ TABLE lt_persk
*      WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
*      TRANSPORTING NO FIELDS.
*
*      IF sy-subrc = 0.
        CLEAR: ls_check_vormonat.
        READ TABLE gt_vsi INTO ls_check_vormonat
          WITH KEY pernr = ls_kapa-pernr.
        IF sy-subrc NE 0.
          ADD ls_kapa-kapa TO lv_menge.
        ENDIF.
*      ENDIF.
      CLEAR: ls_kapa.
    ENDLOOP.

  ELSEIF p_kpi_id = 22.
******************************************************************
* IST-Kapa: Prognosen

    SELECT * FROM zmhp_kapatool_em INTO ls_empl
    WHERE selorgid = p_orgeh
    AND   ( selrowid = '23' OR selrowid = '24' )
    AND   backup02 <= lv_date_first
    AND   ( backup01 = 'ZUGANG' OR backup01 = 'ABGANG' ).

      ADD ls_empl-kapa TO lv_menge.
      CLEAR: ls_empl.
    ENDSELECT.

  ELSEIF p_kpi_id = 23.
******************************************************************
* IST-Kapa: prognostizierte Zugänge

    SELECT * FROM zmhp_kapatool_em INTO ls_empl
    WHERE selorgid = p_orgeh
    AND   ( selrowid = '23' OR selrowid = '24' )
    AND   backup02 <= lv_date_first
    AND   backup01 = 'ZUGANG'.

      ADD ls_empl-kapa TO lv_menge.
      CLEAR: ls_empl.
    ENDSELECT.


  ELSEIF p_kpi_id = 24.
******************************************************************
* IST-Kapa: prognostizierte Abgänge

    SELECT * FROM zmhp_kapatool_em INTO ls_empl
    WHERE selorgid = p_orgeh
    AND   ( selrowid = '23' OR selrowid = '24' )
    AND   backup01 = 'ABGANG'
    AND   austrittsdatum <= lv_date_check. " = vorheriges Monatsende

      lv_menge = lv_menge - ls_empl-kapa.
      CLEAR: ls_empl.
    ENDSELECT.


  ELSEIF p_kpi_id = 30.
******************************************************************
* Rechnerisch offene Kapazität
* Maximal genehmigte Kapazität ./. Ist Kapazität (zum Stichtag)

    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.


  ELSEIF p_kpi_id = 31.
******************************************************************
* Rechnerisch offene Kapazität: Abweichung von Normkapazität
* Definition: Genehmigte Kapa: true / Besetzungsstatus: ohne Aktion / Austritt nicht bekannt
* Wochenarbeitszeit   <   30h   =   0,5 Normkapazität
* Wochenarbeitszeit   >=  30h   =   1,0 Normkapazität

*    LOOP AT gt_vsi INTO ls_kapa
*      WHERE austritt IS INITIAL.
*
*      LOOP AT gt_comparison INTO ls_comparison
*              WHERE plans = ls_kapa-plans.
*
*        IF ls_comparison-besetz_genehmigt = abap_true AND ls_comparison-bes_sta = 1. " Genehmigt + ohne Aktion
*
*          lv_0komma5 = 1 / 2.
*
*          IF ls_kapa-wostd < 30.
*            IF ls_kapa-kapa < lv_0komma5.
*              lv_temp = lv_0komma5 - ls_kapa-kapa.
*              ADD lv_temp TO lv_menge.
*              CLEAR: lv_temp.
*            ELSE.
*              lv_temp = ls_kapa-kapa - lv_0komma5.
*              ADD lv_temp TO lv_menge.
*              CLEAR: lv_temp.
*            ENDIF.
*          ELSE.
*            IF ls_kapa-kapa < 1.
*              lv_temp = 1 - ls_kapa-kapa.
*              ADD lv_temp TO lv_menge.
*              CLEAR: lv_temp.
*            ELSE.
*              lv_temp = ls_kapa-kapa - 1.
*              ADD lv_temp TO lv_menge.
*              CLEAR: lv_temp.
*            ENDIF.
*          ENDIF.
*
*        ENDIF.
*
*        CLEAR: ls_comparison.
*      ENDLOOP.
*      CLEAR: ls_kapa.
*
*    ENDLOOP.

    " ( Summe Kapas von allen "offenen" + Ruhend + Überhang ) - Rechn. Offene Kapa
    LOOP AT gt_comparison INTO ls_comparison.

      IF  ( ls_comparison-gen_kap EQ '0.5'
            OR ls_comparison-gen_kap EQ '1.0' )
      AND ( ls_comparison-bes_sta = 1
            OR ls_comparison-bes_sta = 2
            OR ls_comparison-bes_sta = 3 ).

        READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans.
        IF sy-subrc <> 0.
          lv_menge_tmp = ls_comparison-gen_kap.
          ADD lv_menge_tmp TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, lv_menge_tmp.
    ENDLOOP.

    " Verrechnung mit Rechn. Offene Kapa
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge_tmp = ( gv_sum_max_gen_kapa - gv_sum_vsi ) - lv_menge.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge_tmp = ( gv_sum_vsi - gv_sum_max_gen_kapa ) - lv_menge.
    ELSE.
      lv_menge_tmp = 0.
    ENDIF.

    lv_menge = lv_menge_tmp.
    CLEAR: lv_menge_tmp.


  ELSEIF p_kpi_id = 32.
******************************************************************
* Rechnerisch offene Kapazität: Offen - ohne Aktion
* Definition: Gen. Kapa > 0 / PLANS nicht besetzt / ohne Aktion

    LOOP AT gt_comparison INTO ls_comparison.

      IF ( ls_comparison-gen_kap EQ '0.5' OR ls_comparison-gen_kap EQ '1.0' )
        AND ls_comparison-bes_sta = 1.

        READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans.
        IF sy-subrc <> 0.
          lv_menge_tmp = ls_comparison-gen_kap.
          ADD lv_menge_tmp TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, lv_menge_tmp.
    ENDLOOP.

  ELSEIF p_kpi_id = 33.
******************************************************************
* Rechnerisch offene Kapazität: Besetzung genehmigt
* Definition: Flag = true

    LOOP AT gt_comparison INTO ls_comparison.

      IF ( ls_comparison-gen_kap EQ '0.5' OR ls_comparison-gen_kap EQ '1.0' )
      AND ls_comparison-bes_sta = 1
      AND ls_comparison-bes_gen = abap_true. " genehmight

        READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans.
        IF sy-subrc <> 0.
          lv_menge_tmp = ls_comparison-gen_kap.
          ADD lv_menge_tmp TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, lv_menge_tmp.
    ENDLOOP.


  ELSEIF p_kpi_id = 34.
******************************************************************
* Rechnerisch offene Kapazität: Besetzung nicht genehmigt
* Definition: Flag = false

    LOOP AT gt_comparison INTO ls_comparison.

      IF ( ls_comparison-gen_kap EQ '0.5' OR ls_comparison-gen_kap EQ '1.0' )
      AND ls_comparison-bes_sta = 1
      AND ls_comparison-bes_gen = abap_false. " nicht genehmight

        READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans.
        IF sy-subrc <> 0.
          lv_menge_tmp = ls_comparison-gen_kap.
          ADD lv_menge_tmp TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, lv_menge_tmp.
    ENDLOOP.


  ELSEIF p_kpi_id = 35.
******************************************************************
* Rechnerisch offene Kapazität: Offen - Suche läuft
* Definition: Gen. Kapa > 0 / PLANS nicht besetzt / Suche läuft

    LOOP AT gt_comparison INTO ls_comparison.

      IF ( ls_comparison-gen_kap EQ '0.5' OR ls_comparison-gen_kap EQ '1.0' )
      AND ls_comparison-bes_sta = 2.

        READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans.
        IF sy-subrc <> 0.
          " CZ 14.04
*          lv_menge_tmp = ls_comparison-gen_kap - ls_kapa-kapa.
*          ADD lv_menge_tmp TO lv_menge.
          ADD ls_comparison-gen_kap TO lv_menge.

        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, lv_menge_tmp.
    ENDLOOP.


  ELSEIF p_kpi_id = 36.
******************************************************************
* Rechnerisch offene Kapazität: Offen - Suche abgeschlossen
* Definition: Gen. Kapa > 0 / PLANS nicht besetzt / Suche abgeschlossen

    LOOP AT gt_comparison INTO ls_comparison.

      IF ( ls_comparison-gen_kap EQ '0.5' OR ls_comparison-gen_kap EQ '1.0' )
      AND ls_comparison-bes_sta = 3.

        READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans.
        IF sy-subrc <> 0.
          lv_menge_tmp = ls_comparison-gen_kap - ls_kapa-kapa.
          ADD lv_menge_tmp TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, lv_menge_tmp.
    ENDLOOP.



  ELSEIF p_kpi_id = 37.
******************************************************************
* Rechnerisch offene Kapazität: Ruhend - Stelle freigehalten
* Definition: gen. Kapa > 0 / besetzt mit Ruhendem / Infotyp - ohne Aktion

    LOOP AT gt_comparison INTO ls_comparison WHERE bes_sta = 1 AND gen_kap NE '0.0'.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY ruhend = abap_true
      ruhend_return = abap_true kapa = '0.0' plans = ls_comparison-plans.
      IF sy-subrc = 0.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.

      CLEAR: ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 38.
******************************************************************
* Rechnerisch offene Kapazität: Temporärer Überhang
* Definition: Keine gen. Kapa / Doppelbesetzung oder Überhangstelle
    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap EQ '0,0'.

      CLEAR: ls_kapa.

      IF ls_comparison-bes_gen = abap_false
        AND ( ls_comparison-bes_sta = 4 OR ls_comparison-bes_sta = 5 ).

        READ TABLE gt_vsi INTO ls_kapa
          WITH KEY plans = ls_comparison-plans.

        IF sy-subrc = 0 AND ls_kapa-ruhend = abap_false.
          ADD ls_comparison-gen_kap TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 39.
******************************************************************
* Rechnerisch offene Kapazität: Doppelbesetzung
* Definition: Keine gen. Kapa / Infotypfeld Status - Doppelbesetzung
    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap EQ '0,0'.

      CLEAR: ls_kapa.

      IF ls_comparison-bes_gen = abap_false
        AND ls_comparison-bes_sta = 4.

        READ TABLE gt_vsi INTO ls_kapa
          WITH KEY plans = ls_comparison-plans.

        IF sy-subrc = 0 AND ls_kapa-ruhend = abap_false.
          ADD ls_comparison-gen_kap TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.


  ELSEIF p_kpi_id = 40.
******************************************************************
* Rechnerisch offene Kapazität: Überhangstelle
* Definition: Keine gen. Kapa / Infotypfeld Status - Überhangstelle
    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap EQ '0,0'.

      CLEAR: ls_kapa.

      IF ls_comparison-bes_gen = abap_false
        AND ls_comparison-bes_sta = 5.

        READ TABLE gt_vsi INTO ls_kapa
          WITH KEY plans = ls_comparison-plans.

        IF sy-subrc = 0 AND ls_kapa-ruhend = abap_false.
          ADD ls_comparison-gen_kap TO lv_menge.
        ENDIF.

      ENDIF.

      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 50.
******************************************************************
* Ruhend - ohne Stelle (Rückkehr mgl.)
* keine gen. Kapa / besetzt mit Ruhendem -  kann wiederkommen / Infotyp Status = 1
* Köpfe-KPI, da kein rechn. Offene Kapa vorhanden

    LOOP AT gt_vsi INTO ls_kapa
    WHERE ruhend = abap_true
    AND ruhend_return = abap_true.

      READ TABLE lt_persk
      WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0.
        READ TABLE gt_comparison INTO ls_comparison WITH KEY plans = ls_kapa-plans.
        IF sy-subrc = 0 AND ls_comparison-bes_sta = 1 AND ls_comparison-gen_kap NE '0,0'.
          ADD ls_comparison-gen_kap TO lv_menge.
        ENDIF.
      ENDIF.

      CLEAR: ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 60.
******************************************************************
* Mitarbeiter in Köpfen

    LOOP AT gt_vsi INTO ls_kapa.
      READ TABLE lt_persk
        WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
        TRANSPORTING NO FIELDS.

      IF sy-subrc = 0.
        ADD 1 TO lv_menge.
      ENDIF.

      CLEAR: ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 61.
******************************************************************
* Mitarbeiter in Köpfen: IST-Köpfe

    LOOP AT gt_vsi INTO ls_kapa.

      READ TABLE lt_persk
      WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-ruhend = abap_false.
        ADD 1 TO lv_menge.
      ENDIF.

      CLEAR: ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 62.
******************************************************************
* Mitarbeiter in Köpfen: Ruhende Mitarbeiter (gesamt)

    LOOP AT gt_vsi INTO ls_kapa
      WHERE ruhend = abap_true.

      READ TABLE lt_persk
      WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-ruhend = abap_true.
        ADD 1 TO lv_menge.
      ENDIF.

      CLEAR: ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 70.
******************************************************************
* Anzahl Besetzungsprozesse
* Definition: gen. Kapa > 0 / Besetzstatus 1,2,3 / Plans besetzt / Austritt bekannt

    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0'
      AND ( bes_sta = 1 OR bes_sta = 2 OR bes_sta = 3 ).

      CLEAR: ls_kapa.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-austritt IS NOT INITIAL AND ls_kapa-ruhend = abap_false.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.


      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.



  ELSEIF p_kpi_id = 71.
******************************************************************
* Anzahl Besetzungsprozesse: Besetzungsprozess - ohne Aktion
* Austritt bekannt / Kapa > 0 / Status 1 / Plans besetzt

    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0'  AND bes_sta = 1.

      CLEAR: ls_kapa.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-austritt IS NOT INITIAL AND ls_kapa-ruhend = abap_false.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.


      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.


  ELSEIF p_kpi_id = 72.
******************************************************************
* Anzahl Besetzungsprozesse: Besetzungsprozess genehmigt
* Austritt bekannt / Kapa > 0 / Status 1 & genehmigt

    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0'  AND bes_sta = 1 AND bes_gen = abap_true.

      CLEAR: ls_kapa.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-austritt IS NOT INITIAL AND ls_kapa-ruhend = abap_false.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.


      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.


  ELSEIF p_kpi_id = 73.
******************************************************************
* Anzahl Besetzungsprozesse: Besetzungsprozess nicht genehmigt
* Austritt bekannt / Kapa > 0 / Status 1 & nicht genehmigt

    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0'  AND bes_sta = 1 AND bes_gen = abap_false.

      CLEAR: ls_kapa.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-austritt IS NOT INITIAL AND ls_kapa-ruhend = abap_false.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.


      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.


  ELSEIF p_kpi_id = 74.
******************************************************************
* Anzahl Besetzungsprozesse: Besetzungsprozess - Suche läuft
* Austritt bekannt / Kapa > 0 / Status 2

    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0'  AND bes_sta = 2.

      CLEAR: ls_kapa.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans " Plans besetzt
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-austritt IS NOT INITIAL AND ls_kapa-ruhend = abap_false.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.


      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.


  ELSEIF p_kpi_id = 75.
******************************************************************
* Anzahl Besetzungsprozesse: Besetzungsprozess - Suche abgeschlossen
* Austritt bekannt / Kapa > 0 / Status 3

    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0'  AND bes_sta = 3.

      CLEAR: ls_kapa.

      READ TABLE gt_vsi INTO ls_kapa WITH KEY plans = ls_comparison-plans " Plans besetzt
      TRANSPORTING NO FIELDS.

      IF sy-subrc = 0 AND ls_kapa-austritt IS NOT INITIAL AND ls_kapa-ruhend = abap_false.
        ADD ls_comparison-gen_kap TO lv_menge.
      ENDIF.


      CLEAR: ls_comparison, ls_kapa.
    ENDLOOP.


  ENDIF.


**********************************************************************
  " Exporting the determined value
  IF p_kpi_id EQ 30.
    IF lv_menge > 0.
      MOVE lv_menge TO lv_value.
      SPLIT lv_value AT '.' INTO p_value lv_value.
      CONCATENATE '+' p_value ',' lv_value INTO p_value.
    ELSEIF lv_menge < 0.
      MOVE lv_menge TO lv_value.
      SPLIT lv_value AT '.' INTO p_value lv_value.
      CONCATENATE '-' p_value ',' lv_value(1) INTO p_value.
    ELSE.
      MOVE lv_menge TO lv_value.
      SPLIT lv_value AT '.' INTO p_value lv_value.
      CONCATENATE p_value ',' lv_value INTO p_value.
    ENDIF.
  ELSE.
    MOVE lv_menge TO lv_value.
    SPLIT lv_value AT '.' INTO p_value lv_value.
    CONCATENATE p_value ',' lv_value INTO p_value.
  ENDIF.

ENDFORM.
