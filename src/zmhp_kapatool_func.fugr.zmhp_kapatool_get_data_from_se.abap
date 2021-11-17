FUNCTION zmhp_kapatool_get_data_from_se.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_BUKRS) TYPE  BUKRS OPTIONAL
*"     VALUE(IV_ORGEH) TYPE  ORGEH OPTIONAL
*"     VALUE(IV_LOCATION) TYPE  STRING OPTIONAL
*"     VALUE(IV_BEGDA) TYPE  BEGDA
*"     VALUE(IV_ENDDA) TYPE  ENDDA
*"     VALUE(IV_CUMULATIVE) TYPE  FLAG OPTIONAL
*"     VALUE(IV_BEGDA_CHECK) TYPE  BEGDA
*"     VALUE(IV_ENDDA_CHECK) TYPE  ENDDA
*"     VALUE(IV_COSTCENTRE) TYPE  KOSTL OPTIONAL
*"  EXPORTING
*"     VALUE(ET_VSI) TYPE  ZMHP_KAPATOOL_T_KAPA
*"     VALUE(ET_COMPARISON) TYPE  ZMHP_KAPATOOL_T_COMP
*"     VALUE(ET_VSI_VORMONAT) TYPE  ZMHP_KAPATOOL_T_KAPA
*"----------------------------------------------------------------------

  "----------------------------------------------------------------------
  "*"Lokale Schnittstelle:
  "  IMPORTING
  "     VALUE(IV_BUKRS) TYPE  BUKRS OPTIONAL
  "     VALUE(IV_ORGEH) TYPE  ORGEH OPTIONAL
  "     VALUE(IV_LOCATION) TYPE  STRING OPTIONAL
  "     VALUE(IV_BEGDA) TYPE  BEGDA
  "     VALUE(IV_ENDDA) TYPE  ENDDA
  "     VALUE(IV_CUMULATIVE) TYPE  FLAG OPTIONAL
  "  EXPORTING
  "     VALUE(ET_VSI) TYPE  ZHR06_T_KAPA
  "     VALUE(ET_COMPARISON) TYPE  ZHR06_T_COMPARISON
  "----------------------------------------------------------------------

  DATA:        lt_orgunits       TYPE TABLE OF swhactor,
               ls_orgunits       TYPE swhactor,
               lt_result         TYPE TABLE OF swhactor,
               ls_result         TYPE swhactor,
               lt_result_objec   TYPE TABLE OF objec,
               ls_result_objec   TYPE objec,
               ls_check_vormonat TYPE zhr06_s_kapa, " fix czakaj 16.03
               ls_kapa           TYPE zhr06_s_kapa, " fix czakaj 16.03
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
               lt_p0002          TYPE TABLE OF p0002,
               ls_p0002          TYPE p0002,
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
               ls_empl           TYPE zmhp_kapatool_em,
               lv_date_first     TYPE dats,
               lt_persk          TYPE TABLE OF zmhp_kapatool_pe,
               ls_persk          TYPE zmhp_kapatool_pe,
               lv_plans_id       TYPE plog-objid,
               lt_p9922          TYPE TABLE OF p9922,
               ls_p9922          TYPE p9922,
               lv_tdepth         TYPE hrrhas-tdepth,
               ls_basis_std      TYPE zmhp_kapatool_bw,
               ls_comparison     TYPE zhr06_s_comparison, " fix czakaj 16.03
               lv_0komma5        TYPE zmhp_kapatool_men,
               lv_temp           TYPE zmhp_kapatool_men,
               lt_hrp1000        TYPE TABLE OF hrp1000,
               ls_hrp1000        TYPE hrp1000,
               lv_bukrs          TYPE bukrs,
               lv_kokrs          TYPE kokrs,
               lv_kokrs_check    TYPE kokrs,
               lv_short          TYPE short_d,
               lv_long           TYPE stext.

**********************************************************************
* CHECK INITIATED SELECTION
**********************************************************************

  REFRESH: lt_orgunits.

  IF gv_plvar IS INITIAL.
    gv_plvar = '01'.
  ENDIF.

  IF iv_orgeh IS NOT INITIAL.
    CLEAR: iv_bukrs, iv_costcentre, iv_location. " only one can be evaluated

    ls_orgunits-objid = iv_orgeh.
    ls_orgunits-otype = 'O'.
    APPEND ls_orgunits TO lt_orgunits.

    CLEAR: ls_orgunits.
  ENDIF.

  IF iv_bukrs IS NOT INITIAL.
    CLEAR: iv_orgeh, iv_costcentre, iv_location. " only one can be evaluated

    SELECT * FROM hrp1000 INTO TABLE lt_hrp1000
    WHERE plvar = gv_plvar
    AND otype = 'O'
    AND begda <= iv_begda
    AND endda >= iv_endda.

    LOOP AT lt_hrp1000 INTO ls_hrp1000.

      CALL FUNCTION 'RH_GET_CONTROLLING_INFO'
        EXPORTING
          plvar          = gv_plvar
          otype          = 'O'
          objid          = ls_hrp1000-objid
          sel_date       = sy-datum
          status         = '1'
          read_not_t77s0 = ' '
        IMPORTING
*         KOKRS          =
          bukrs          = lv_bukrs
*         GSBER          =
*         PERSA          =
*         BTRTL          =
*         RET_OTYPE      =
*         RET_OBJID      =
        EXCEPTIONS
          not_found      = 1
          OTHERS         = 2.

      IF sy-subrc = 0 AND lv_bukrs EQ iv_bukrs.
        ls_orgunits-objid = ls_hrp1000-objid.
        ls_orgunits-otype = 'O'.
        APPEND ls_orgunits TO lt_orgunits.
      ENDIF.

      CLEAR: ls_hrp1000, lv_bukrs, ls_orgunits.
    ENDLOOP.

  ENDIF.

  IF iv_location IS NOT INITIAL.
    CLEAR: iv_orgeh, iv_costcentre, iv_bukrs. " only one can be evaluated


    CLEAR: ls_orgunits.
  ENDIF.

  IF iv_costcentre IS NOT INITIAL.
    CLEAR: iv_orgeh, iv_bukrs, iv_location. " only one can be evaluated

    " von Kostenstelle zu KOKRS und wieder über Org.-Einheiten!
    SELECT SINGLE kokrs FROM csks INTO lv_kokrs
        WHERE kostl EQ iv_costcentre
        AND datab <= iv_begda
        AND datbi >= iv_endda.

    SELECT * FROM hrp1000 INTO TABLE lt_hrp1000
        WHERE plvar = gv_plvar
        AND otype = 'O'
        AND begda <= iv_begda
        AND endda >= iv_endda.

    LOOP AT lt_hrp1000 INTO ls_hrp1000.

      CALL FUNCTION 'RH_GET_CONTROLLING_INFO'
        EXPORTING
          plvar          = gv_plvar
          otype          = 'O'
          objid          = ls_hrp1000-objid
          sel_date       = sy-datum
          status         = '1'
          read_not_t77s0 = ' '
        IMPORTING
          kokrs          = lv_kokrs_check
*         BUKRS          =
*         GSBER          =
*         PERSA          =
*         BTRTL          =
*         RET_OTYPE      =
*         RET_OBJID      =
        EXCEPTIONS
          not_found      = 1
          OTHERS         = 2.

      IF sy-subrc = 0 AND lv_kokrs EQ lv_kokrs_check.
        ls_orgunits-objid = ls_hrp1000-objid.
        ls_orgunits-otype = 'O'.
        APPEND ls_orgunits TO lt_orgunits.
      ENDIF.

      CLEAR: ls_hrp1000, lv_kokrs_check, ls_orgunits.
    ENDLOOP.

    CLEAR: ls_orgunits, lv_kokrs.
  ENDIF.

**********************************************************************
* Fill ET_COMPARISON (PLANS-TABLE)
**********************************************************************
  LOOP AT lt_orgunits INTO ls_orgunits.

    IF iv_cumulative = 'X'.
      lv_tdepth = 0. " all & below
    ELSE.
      lv_tdepth = 2. " only O-S
    ENDIF.

    REFRESH: lt_result.

    CALL FUNCTION 'RH_STRUC_GET'
      EXPORTING
        act_otype       = 'O'
        act_objid       = ls_orgunits-objid
        act_wegid       = 'O-S-P'
        act_plvar       = gv_plvar
        act_begda       = iv_begda
        act_endda       = iv_endda
        act_tdepth      = lv_tdepth " re-check on TRUMPF system if this is enough ok for cumulative/non-cumulative view
        authority_check = 'X'
      TABLES
        result_tab      = lt_result
      EXCEPTIONS
        no_plvar_found  = 1
        no_entry_found  = 2
        OTHERS          = 3.

    LOOP AT lt_result INTO ls_result
    WHERE otype = 'S'.

      REFRESH lt_p9922.
      CLEAR: lv_plans_id.

      MOVE ls_result-objid TO lv_plans_id.

      CALL FUNCTION 'RH_READ_INFTY'
        EXPORTING
          authority            = 'DISP'
          with_stru_auth       = 'X'
          plvar                = gv_plvar
          otype                = 'S'
          objid                = lv_plans_id
          infty                = '9922'
          begda                = iv_begda
          endda                = iv_endda
        TABLES
          innnn                = lt_p9922
*         OBJECTS              =
        EXCEPTIONS
          all_infty_with_subty = 1
          nothing_found        = 2
          no_objects           = 3
          wrong_condition      = 4
          wrong_parameters     = 5
          OTHERS               = 6.

      IF lt_p9922 IS NOT INITIAL.
        SORT lt_p9922 BY endda DESCENDING begda DESCENDING.
        READ TABLE lt_p9922 INTO ls_p9922 INDEX 1.

        REPLACE ',' IN ls_p9922-genehm_kapa WITH '.'.
*        ADD ls_p9922-genehm_kapa TO lv_menge.
*        ADD ls_p9922-genehm_kapa TO gv_sum_max_gen_kapa.

        " Alle PLANS - Details wegsichern
        MOVE-CORRESPONDING ls_p9922 TO ls_comparison.
        ls_comparison-plans = lv_plans_id.
        APPEND ls_comparison TO et_comparison.

      ENDIF.

      CLEAR: ls_p9922.

    ENDLOOP.

**********************************************************************
* Fill GT_VSI Table (Employee-Details)
**********************************************************************

    REFRESH: lt_result.
    CALL FUNCTION 'RH_STRUC_GET'
      EXPORTING
        act_otype       = 'O'
        act_objid       = ls_orgunits-objid
        act_wegid       = 'O-S-P'
        act_plvar       = '01'
        act_begda       = iv_begda
        act_endda       = iv_endda
        act_tdepth      = lv_tdepth
        authority_check = 'X'
      TABLES
        result_tab      = lt_result
*       RESULT_OBJEC    = lt_result_objec
*       RESULT_STRUC    =
      EXCEPTIONS
        no_plvar_found  = 1
        no_entry_found  = 2
        OTHERS          = 3.

    LOOP AT lt_result INTO ls_result
    WHERE otype = 'P'.

      MOVE ls_result-objid TO lv_pernr.
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = lv_pernr
          infty           = '0000'
          begda           = iv_begda
          endda           = iv_endda
        TABLES
          infty_tab       = lt_p0000
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

      SORT lt_p0000 BY begda DESCENDING.
      READ TABLE lt_p0000 INTO ls_p0000 INDEX 1.

      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = lv_pernr
          infty           = '0001'
          begda           = iv_begda
          endda           = iv_endda
        TABLES
          infty_tab       = lt_p0001
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

      IF sy-subrc <> 0.
*           Implement suitable error handling here
      ENDIF.

      SORT lt_p0001 BY begda DESCENDING.
      READ TABLE lt_p0001 INTO ls_p0001 INDEX 1.

      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = lv_pernr
          infty           = '0002'
          begda           = iv_begda
          endda           = iv_endda
        TABLES
          infty_tab       = lt_p0002
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

      IF sy-subrc <> 0.
*           Implement suitable error handling here
      ENDIF.

      SORT lt_p0002 BY begda DESCENDING.
      READ TABLE lt_p0002 INTO ls_p0002 INDEX 1.

      REFRESH lt_leave_dates[].
      CLEAR: lv_leavedate, ls_leave_dates.

      " Austritt absehbar?
      CALL FUNCTION 'HR_LEAVE_DATE_CALC'
        EXPORTING
          persnr                 = lv_pernr
          begda                  = sy-datum
          switch                 = lv_switch_leave
        IMPORTING
          leavingdate            = lv_leavedate
        TABLES
          leaving_dates          = lt_leave_dates[]
        EXCEPTIONS
          leaving_date_not_found = 1
          OTHERS                 = 2.

      IF lt_leave_dates[] IS NOT INITIAL OR lv_leavedate IS NOT INITIAL. " Austritt bekannt
        IF lv_leavedate IS NOT INITIAL.
          ls_kapa-austritt = lv_leavedate.
        ELSE.
          READ TABLE lt_leave_dates[] INTO ls_leave_dates INDEX 1.
          ls_kapa-austritt = ls_leave_dates-begda.
        ENDIF.
      ELSE.
        CLEAR: ls_kapa-austritt.
      ENDIF.

      " Mitarbeiter in ruhendem AV
      CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_INACTIV'
        EXPORTING
          iv_pernr        = lv_pernr
          is_p0000        = ls_p0000
          is_p0001        = ls_p0001
        IMPORTING
          ev_is_inactive  = ls_kapa-ruhend
          ev_might_return = ls_kapa-ruhend_return.

      " Wostd ermitteln
      CALL FUNCTION 'HR_READ_INFOTYPE_AUTHC_DISABLE'.
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = lv_pernr
          infty           = '0007'
          begda           = iv_begda
          endda           = iv_endda
        TABLES
          infty_tab       = lt_p0007
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

      IF sy-subrc <> 0.
*             Implement suitable error handling here
      ENDIF.

      SORT lt_p0007 BY begda DESCENDING.
      READ TABLE lt_p0007 INTO ls_p0007 INDEX 1.

      IF ls_p0007-wostd IS NOT INITIAL.

        CLEAR: ls_basis_std.
        SELECT SINGLE * FROM zhr06_bw_arbzeit INTO ls_basis_std " fix czakaj 16.03
        WHERE bukrs = ls_p0001-bukrs.

        " 2 do Bfa und BAV Stunden noch draufzählen !!
*             customizbar welche AWARTEN

        IF ls_basis_std IS NOT INITIAL.
          IF ls_basis_std-wostd NE ls_p0007-wostd.
            lv_kapa = ( 1 / ls_basis_std-wostd ) * ls_p0007-wostd.
          ELSE.
            lv_kapa = 1.
          ENDIF.
        ENDIF.

        " Testdaten
        IF ls_p0001-pernr = '00000014'.
          lv_kapa = 0.
        ENDIF.

      ELSE. " bspw. bei Ministamm (LS_P0001-ZHRKAPA verwenden)

        " 2 do TRUMPF System
*            CLEAR: ls_basis_std.
*            SELECT SINGLE * FROM zmhp_kapatool_bw_arbzeit INTO ls_basis_std
*            WHERE bukrs = ls_p0001-bukrs AND wostd = ls_p0001-zhrkapa.

      ENDIF.

*        ADD lv_kapa TO lv_menge.
*        ADD lv_kapa TO gv_sum_vsi.

      ls_kapa-wostd = ls_p0007-wostd.
      ls_kapa-pernr = lv_pernr.
      ls_kapa-bukrs = ls_p0001-bukrs.
      ls_kapa-orgeh = ls_p0001-orgeh.
      ls_kapa-persk = ls_p0001-persk.
      ls_kapa-kapa = lv_kapa.
      ls_kapa-it0001_begda = ls_p0001-begda.
      ls_kapa-it0001_endda = ls_p0001-endda.
      ls_kapa-plans = ls_p0001-plans.
      ls_kapa-stichtag = lv_date.
      ls_kapa-vorna = ls_p0002-vorna.
      ls_kapa-nachn = ls_p0002-nachn.

      CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
        EXPORTING
          im_plvar = gv_plvar
          im_otype = 'O'
          im_objid = ls_p0001-orgeh
          im_begda = sy-datum
          im_endda = sy-datum
        IMPORTING
          short    = lv_short
          long     = lv_long.

      ls_kapa-orgshort = lv_short.

      APPEND ls_kapa TO et_vsi.

      REFRESH: lt_p0000, lt_p0001, lt_p0007, lt_p0002.
      CLEAR: ls_result, ls_p0000, ls_p0001, ls_p0002, ls_p0007, ls_kapa, lv_pernr, lv_kapa, lv_short, lv_long.
    ENDLOOP.

    "******************************************************************************
    " Vormonat

    REFRESH: lt_result, lt_p0000, lt_p0001, lt_p0007.
    CALL FUNCTION 'RH_STRUC_GET'
      EXPORTING
        act_otype       = 'O'
        act_objid       = ls_orgunits-objid
        act_wegid       = 'O-S-P'
        act_plvar       = '01'
        act_begda       = iv_begda_check
        act_endda       = iv_endda_check
        act_tdepth      = lv_tdepth
        authority_check = 'X'
      TABLES
        result_tab      = lt_result
*       RESULT_OBJEC    = lt_result_objec
*       RESULT_STRUC    =
      EXCEPTIONS
        no_plvar_found  = 1
        no_entry_found  = 2
        OTHERS          = 3.
    IF sy-subrc <> 0.
*       Implement suitable error handling here
    ENDIF.

    LOOP AT lt_result INTO ls_result
    WHERE otype = 'P'.

      MOVE ls_result-objid TO lv_pernr.
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
*         TCLAS           = 'A'
          pernr           = lv_pernr
          infty           = '0000'
          begda           = iv_begda_check
          endda           = iv_endda_check
        TABLES
          infty_tab       = lt_p0000
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
*         Implement suitable error handling here
      ENDIF.
      SORT lt_p0000 BY begda DESCENDING.
      READ TABLE lt_p0000 INTO ls_p0000 INDEX 1.

      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
*         TCLAS           = 'A'
          pernr           = lv_pernr
          infty           = '0001'
          begda           = iv_begda_check
          endda           = iv_endda_check
        TABLES
          infty_tab       = lt_p0001
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
*           Implement suitable error handling here
      ENDIF.

      SORT lt_p0001 BY begda DESCENDING.
      READ TABLE lt_p0001 INTO ls_p0001 INDEX 1.

      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = lv_pernr
          infty           = '0002'
          begda           = iv_begda
          endda           = iv_endda
        TABLES
          infty_tab       = lt_p0002
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.

      IF sy-subrc <> 0.
*           Implement suitable error handling here
      ENDIF.

      SORT lt_p0002 BY begda DESCENDING.
      READ TABLE lt_p0002 INTO ls_p0002 INDEX 1.

      REFRESH lt_leave_dates[].
      CLEAR: lv_leavedate, ls_leave_dates.

      CALL FUNCTION 'HR_LEAVE_DATE_CALC'
        EXPORTING
          persnr                 = lv_pernr
          begda                  = sy-datum
          switch                 = lv_switch_leave
        IMPORTING
          leavingdate            = lv_leavedate
        TABLES
          leaving_dates          = lt_leave_dates[]
        EXCEPTIONS
          leaving_date_not_found = 1
          OTHERS                 = 2.

      IF lt_leave_dates[] IS NOT INITIAL OR lv_leavedate IS NOT INITIAL. " Austritt bekannt

        IF lv_leavedate IS NOT INITIAL.
          ls_kapa-austritt = lv_leavedate.
        ELSE.
          READ TABLE lt_leave_dates[] INTO ls_leave_dates INDEX 1.
          ls_kapa-austritt = ls_leave_dates-begda.
        ENDIF.
      ELSE.
        CLEAR: ls_kapa-austritt.
      ENDIF.

      " Mitarbeiter in ruhendem AV
      CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_INACTIV'
        EXPORTING
          iv_pernr       = lv_pernr
          is_p0000       = ls_p0000
          is_p0001       = ls_p0001
        IMPORTING
          ev_is_inactive = ls_kapa-ruhend.

      CALL FUNCTION 'HR_READ_INFOTYPE_AUTHC_DISABLE'.
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
*         TCLAS           = 'A'
          pernr           = lv_pernr
          infty           = '0007'
          begda           = iv_begda_check
          endda           = iv_endda_check
        TABLES
          infty_tab       = lt_p0007
        EXCEPTIONS
          infty_not_found = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
*             Implement suitable error handling here
      ENDIF.

      SORT lt_p0007 BY begda DESCENDING.
      READ TABLE lt_p0007 INTO ls_p0007 INDEX 1.

      IF ls_p0007-wostd IS NOT INITIAL.

        CLEAR: ls_basis_std.
        SELECT SINGLE * FROM zmhp_kapatool_bw INTO ls_basis_std
        WHERE bukrs = ls_p0001-bukrs.

        " 2 do Bfa und BAV Stunden noch draufzählen !!
*             customizbar welche AWARTEN

        IF ls_basis_std IS NOT INITIAL.
          IF ls_basis_std-wostd NE ls_p0007-wostd.
            lv_kapa = ( 1 / ls_basis_std-wostd ) * ls_p0007-wostd.
          ELSE.
            lv_kapa = 1.
          ENDIF.
        ENDIF.

        " Testdaten
        IF ls_p0001-pernr = '00000014'.
          lv_kapa = 0.
        ENDIF.

      ELSE. " bspw. bei Ministamm (LS_P0001-ZHRKAPA verwenden)

        " 2 do TRUMPF System
*            CLEAR: ls_basis_std.
*            SELECT SINGLE * FROM zmhp_kapatool_bw_arbzeit INTO ls_basis_std
*            WHERE bukrs = ls_p0001-bukrs AND wostd = ls_p0001-zhrkapa.

      ENDIF.

*        ADD lv_kapa TO lv_menge.
*        ADD lv_kapa TO gv_sum_vsi.

      ls_kapa-wostd = ls_p0007-wostd.
      ls_kapa-pernr = lv_pernr.
      ls_kapa-bukrs = ls_p0001-bukrs.
      ls_kapa-orgeh = ls_p0001-orgeh.
      ls_kapa-persk = ls_p0001-persk.
      ls_kapa-kapa = lv_kapa.
      ls_kapa-it0001_begda = ls_p0001-begda.
      ls_kapa-it0001_endda = ls_p0001-endda.
      ls_kapa-plans = ls_p0001-plans.
      ls_kapa-stichtag = lv_date_check.

      ls_kapa-vorna = ls_p0002-vorna.
      ls_kapa-nachn = ls_p0002-nachn.

      CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
        EXPORTING
          im_plvar = gv_plvar
          im_otype = 'O'
          im_objid = ls_p0001-orgeh
          im_begda = sy-datum
          im_endda = sy-datum
        IMPORTING
          short    = lv_short
          long     = lv_long.

      ls_kapa-orgshort = lv_short.

      APPEND ls_kapa TO et_vsi_vormonat.

      REFRESH: lt_p0000, lt_p0001, lt_p0007, lt_p0002.
      CLEAR: ls_result, ls_p0000, ls_p0001, ls_p0007, ls_kapa, lv_pernr, lv_kapa, lv_short, lv_long, ls_p0002.
    ENDLOOP.

    CLEAR: ls_orgunits.
  ENDLOOP.

ENDFUNCTION.
