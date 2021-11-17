FUNCTION zmhp_kapatool_get_data_emp .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_ORGID) TYPE  ORGEH OPTIONAL
*"     VALUE(IV_CUMULATE) TYPE  FLAG OPTIONAL
*"     VALUE(IV_BEGDA) TYPE  BEGDA
*"     VALUE(IV_ENDDA) TYPE  ENDDA OPTIONAL
*"     VALUE(IV_ROW_ID) TYPE  STRING
*"     VALUE(IV_ROW_TITLE) TYPE  STRING OPTIONAL
*"     VALUE(IV_KOSTL) TYPE  KOSTL OPTIONAL
*"     VALUE(IV_BUKRS) TYPE  BUKRS OPTIONAL
*"     VALUE(IV_LOCATION) TYPE  STRING OPTIONAL
*"  EXPORTING
*"     VALUE(ET_EMPLOYEES) TYPE
*"        ZCL_ZMHP_KAPAZITAETSPL_MPC=>TT_EMPLOYEELIST
*"----------------------------------------------------------------------

*  Typen
  TYPES BEGIN OF ty_pernr.
          INCLUDE STRUCTURE swhactor.
  TYPES END OF ty_pernr.

* Konstanten
  CONSTANTS lc_aw_osp TYPE gdstr-wegid VALUE 'O-S-P'.
  CONSTANTS lc_kapa_05 TYPE string VALUE '0,5'.
  CONSTANTS lc_kapa_1 TYPE string VALUE '1,0'.

*Daten
  DATA: ls_employees          TYPE                   zcl_zmhp_kapazitaetspl_mpc=>ts_employeelist,
        lt_employees          TYPE                   zcl_zmhp_kapazitaetspl_mpc=>tt_employeelist,
        lv_success            TYPE flag,
        ls_wconfig            TYPE zmhp_kapatool_wc,
        lv_plvar              TYPE                   plvar,
        lv_geschl_txt         TYPE                   ddtext,
        lv_pernr              TYPE                   prelp-pernr,
        lv_orgeh_s            TYPE                   short_d,
        lv_orgeh_l            TYPE                   stext,
        lv_kapa               TYPE                   string,
        lv_switch_leave       TYPE                   hrpad_leave_switch,
        lv_befristet          TYPE                   char10,
        lv_leavedate          TYPE                   d,
        lv_leavedate_ext      TYPE                  char10,
        lt_orgunits           TYPE TABLE OF swhactor,
        ls_orgunit            TYPE swhactor,
        lt_result             TYPE TABLE OF swhactor,
        ls_result             TYPE swhactor,
        lt_pernr              TYPE TABLE OF          ty_pernr,
        lt_pernr_vorm         TYPE TABLE OF          ty_pernr,
        ls_check_vormonat     TYPE                 ty_pernr,
        ls_p0000              LIKE                   p0000,
        lt_p0000              TYPE TABLE OF          p0000,
        ls_p0001              LIKE                   p0001,
        ls_p0001_old          LIKE                   p0001,
        ls_p0001_tmp          LIKE                   p0001,
        lt_p0001              TYPE TABLE OF          p0001,
        lt_p0001_old          TYPE TABLE OF          p0001,
        ls_p0002              LIKE                   p0002,
        lt_p0002              TYPE TABLE OF          p0002,
        ls_p0007              LIKE                   p0007,
        lt_p0007              TYPE TABLE OF          p0007,
        lv_orgeh_cum          TYPE orgeh,
        lv_orgeh              TYPE orgeh,
        lt_leave_dates        TYPE STANDARD TABLE OF hida,
        lv_short              TYPE                   short_d,
        lv_stext              TYPE                   stext,
        lv_length             TYPE                   i,
        lv_date_check         TYPE                   dats,
        lv_date_check2        TYPE                   dats,
        lv_persk              TYPE                   pktxt,
        lv_begda_format       TYPE                   char10,
        lt_locals             TYPE TABLE OF          zmhp_kapatool_em,
        ls_locals             TYPE                   zmhp_kapatool_em,
        lv_monat              TYPE                   char2,
        lv_date_last          TYPE                   dats,
        lv_add_ok             TYPE                   wdy_boolean,
        ls_data_check         TYPE                   zcl_zmhp_kapazitaetspl_mpc=>ts_employeelist,
        ls_empl_check         TYPE                   zcl_zmhp_kapazitaetspl_mpc=>ts_employeelist,
        lv_string_p0001_endda TYPE string,
        lv_string_p0001_begda TYPE string,
        lv_date               TYPE dats,
        lv_abgang             TYPE endda,
        lt_persk              TYPE TABLE OF zmhp_kapatool_pe,
        ls_persk              TYPE zmhp_kapatool_pe,
        lv_pernr_105          TYPE         p0105-pernr,
        lv_usrid              TYPE         p0105-usrid,
        ls_vsi                TYPE zhr06_s_kapa,
        ls_comparison         LIKE LINE OF gt_comparison,
        lv_long               TYPE stext,
        lv_domvalue           TYPE dd07v-domvalue_l,
        lv_domtext            TYPE dd07v-ddtext,
        lv_menge              TYPE zmhp_kapatool_men,
        lv_menge_tmp          TYPE zmhp_kapatool_men,
        lv_lines              TYPE i.


* Feldsymbol
  FIELD-SYMBOLS:        <gfs_pernr> LIKE swhactor.

  CALL FUNCTION 'RH_GET_ACTIVE_WF_PLVAR'
    IMPORTING
      act_plvar       = lv_plvar
    EXCEPTIONS
      no_active_plvar = 1
      OTHERS          = 2.

  MOVE lv_plvar TO gv_plvar.

* Getting Table Configuration
  CALL FUNCTION 'ZMHP_KAPATOOL_GET_CONF_WC'
    IMPORTING
      es_zmhp_kapatool_wconfig = ls_wconfig
      ev_success               = lv_success.

**********************************************************************
* Get PERSK Customizing (Czakaj, 16.01.2015)
**********************************************************************
  SELECT * FROM zmhp_kapatool_pe INTO TABLE lt_persk.

**********************************************************************
* setting check date for month before

  IF ls_wconfig-gj_display = 'X'.
    lv_date_check+6(2) = '31'.
    lv_date_check+4(2) = '12'.
    lv_date_check(4) = iv_begda(4) - 1.
  ELSE.
    IF iv_begda+4(2) = '01'.
      lv_date_check+6(2) = '31'.
      lv_date_check+4(2) = '12'.
      lv_date_check(4) = iv_begda(4) - 1.

    ELSEIF iv_begda+4(2) = '02'.
      lv_date_check+6(2) = '31'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '03'.
      lv_date_check+6(2) = '28'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '04'.
      lv_date_check+6(2) = '31'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '05'.
      lv_date_check+6(2) = '30'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '06'.
      lv_date_check+6(2) = '31'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '07'.
      lv_date_check+6(2) = '30'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '08'.
      lv_date_check+6(2) = '30'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '09'.
      lv_date_check+6(2) = '31'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '10'.
      lv_date_check+6(2) = '30'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '11'.
      lv_date_check+6(2) = '31'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).

    ELSEIF iv_begda+4(2) = '12'.
      lv_date_check+6(2) = '30'.
      lv_date_check+4(2) = iv_begda+4(2) - 1.
      lv_date_check(4) = iv_begda(4).
    ENDIF.
  ENDIF.

  CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
    EXPORTING
      date                      = lv_date_check
    EXCEPTIONS
      plausibility_check_failed = 1
      OTHERS                    = 2.

  IF sy-subrc <> 0.
    lv_date_check = iv_begda.
  ENDIF.

  lv_date_check2 = lv_date_check.
  lv_date_check2+6(2) = '01'.

  " letzter des monatsende benötigt für abgänge
  CALL FUNCTION 'DATE_GET_MONTH_LASTDAY'
    EXPORTING
      i_date = lv_date_check
    IMPORTING
      e_date = lv_date_last.

** getting orgunit short
*  CLEAR: lv_short, lv_stext, lv_length.
*  SELECT SINGLE short stext FROM hrp1000 INTO (lv_short, lv_stext)
*  WHERE objid = iv_orgid
*  AND   otype = 'O'
*  AND   begda <= sy-datum
*  AND   endda >= sy-datum.
*
*  lv_length = strlen( lv_short ).

  IF iv_orgid EQ '99999999' OR iv_orgid EQ 99999999. " initialer Aufruf, eigene Orgeh lesen

    " initialer Aufruf, cumulate it!
    iv_cumulate = abap_true.

    MOVE sy-uname TO lv_usrid.
    CALL FUNCTION 'RP_GET_PERNR_FROM_USERID'
      EXPORTING
        begda     = sy-datum
        endda     = sy-datum
        usrid     = lv_usrid
        usrty     = '0001'
      IMPORTING
        usr_pernr = lv_pernr_105
      EXCEPTIONS
        retcd     = 1
        OTHERS    = 2.

    IF lv_pernr_105 IS NOT INITIAL.
      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr           = lv_pernr_105
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
        MOVE ls_p0001-orgeh TO lv_orgeh.
      ENDIF.
    ENDIF.

    CLEAR: ls_p0001, lv_usrid.
    REFRESH: lt_p0001.

  ENDIF.

  IF lv_orgeh IS INITIAL.
    MOVE iv_orgid TO lv_orgeh.
  ENDIF.

*  MOVE iv_orgid to lv_orgeh.

  CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_FROM_SE'
    EXPORTING
      iv_bukrs        = iv_bukrs
      iv_costcentre   = iv_kostl
      iv_orgeh        = lv_orgeh
      iv_location     = iv_location
      iv_begda        = iv_endda"iv_begda " not date_first -> Stichtagsbezogen, also ENDDA auch BEGDA
      iv_endda        = iv_endda
      iv_cumulative   = iv_cumulate
      iv_begda_check  = lv_date_check
      iv_endda_check  = lv_date_check
    IMPORTING
      et_vsi          = gt_vsi
      et_vsi_vormonat = gt_vsi_vormonat
      et_comparison   = gt_comparison.

  IF iv_row_id = 2 OR iv_row_id = 30. " Rechnerisch offene Kapa // Max. Gen. Kapa

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison.

      ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.
      ls_employees-plansid = ls_comparison-plans.
      ls_employees-category = ls_comparison-bes_sta.
      ls_employees-maxgenkapa = ls_comparison-gen_kap.

      MOVE ls_comparison-bes_sta TO lv_domvalue.

      CALL FUNCTION 'DOMAIN_VALUE_GET'
        EXPORTING
          i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
          i_domvalue = lv_domvalue
        IMPORTING
          e_ddtext   = lv_domtext
        EXCEPTIONS
          not_exist  = 1
          OTHERS     = 2.

      MOVE lv_domtext TO ls_employees-category.

      CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
        EXPORTING
          im_plvar = gv_plvar
          im_otype = 'S'
          im_objid = ls_comparison-plans
          im_begda = sy-datum
          im_endda = sy-datum
        IMPORTING
          short    = lv_short
          long     = lv_long.

      CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
      CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.

      IF sy-subrc = 0.

        ls_employees-pernr = ls_vsi-pernr.
        ls_employees-employeelistid = ls_vsi-pernr.
        ls_employees-istkapa = ls_vsi-kapa.
        ls_employees-firstname = ls_vsi-vorna.
        ls_employees-lastname = ls_vsi-nachn.
        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa - ls_employees-istkapa.
        ADD ls_vsi-kapa TO gv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

      ELSE. " plans nicht besetzt (Kategorie offen)

        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa.
        ls_employees-istkapa = '0.0'.

      ENDIF.

      APPEND ls_employees TO lt_employees.
      CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext, ls_vsi, ls_employees, ls_comparison, lv_menge_tmp.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    CLEAR: ls_employees.
    ls_employees-planstext = 'Gesamt'.
    ls_employees-pernr = '99999999'.
    ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
    ls_employees-istkapa = gv_sum_vsi.

    IF lv_menge = 0.
      ls_employees-rechnoffenkapa = '0.0'.
    ELSE.
      ls_employees-rechnoffenkapa = lv_menge.
    ENDIF.

    APPEND ls_employees TO lt_employees.
    CLEAR: ls_employees.

  ELSEIF iv_row_id = 19. " IST-Kapa

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.

      IF sy-subrc = 0.

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.
        ls_employees-plansid = ls_comparison-plans.
        ls_employees-category = ls_comparison-bes_sta.
        ls_employees-maxgenkapa = ls_comparison-gen_kap.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        MOVE lv_domtext TO ls_employees-category.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-pernr = ls_vsi-pernr.
        ls_employees-employeelistid = ls_vsi-pernr.
        ls_employees-istkapa = ls_vsi-kapa.
        ls_employees-firstname = ls_vsi-vorna.
        ls_employees-lastname = ls_vsi-nachn.
        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa - ls_employees-istkapa.
        ADD ls_vsi-kapa TO gv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext, ls_vsi, ls_employees, ls_comparison, lv_menge_tmp.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    CLEAR: ls_employees.
    ls_employees-planstext = 'Gesamt'.
    ls_employees-pernr = '99999999'.
    ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
    ls_employees-istkapa = gv_sum_vsi.

    IF lv_menge = 0.
      ls_employees-rechnoffenkapa = '0.0'.
    ELSE.
      ls_employees-rechnoffenkapa = lv_menge.
    ENDIF.

    APPEND ls_employees TO lt_employees.
    CLEAR: ls_employees.

  ELSEIF iv_row_id = 20.
******************************************************************
* IST-Kapa: Zugänge

    LOOP AT gt_vsi INTO ls_vsi.

*      READ TABLE lt_persk
*        WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
*        TRANSPORTING NO FIELDS.
*
*      IF sy-subrc = 0.
      CLEAR: ls_check_vormonat.
      READ TABLE gt_vsi_vormonat INTO ls_check_vormonat
        WITH KEY pernr = ls_vsi-pernr.
      IF sy-subrc NE 0.
READ TABLE gt_comparison into ls_comparison with key plans = ls_vsi-plans.
                MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        MOVE lv_domtext TO ls_employees-category.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.
        ls_employees-plansid = ls_comparison-plans.
        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-pernr = ls_vsi-pernr.
        ls_employees-employeelistid = ls_vsi-pernr.
        ls_employees-istkapa = ls_vsi-kapa.
        ls_employees-firstname = ls_vsi-vorna.
        ls_employees-lastname = ls_vsi-nachn.
        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa - ls_employees-istkapa.
        ADD ls_vsi-kapa TO gv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        APPEND ls_employees TO lt_employees.
      ENDIF.
*      ENDIF.
      CLEAR: ls_vsi, ls_employees.

    ENDLOOP.


  ELSEIF iv_row_id = 21.
******************************************************************
* IST-Kapa: Abgänge

    LOOP AT gt_vsi_vormonat INTO ls_vsi.

*      READ TABLE lt_persk
*      WITH KEY kpi_id = p_kpi_id persk = ls_kapa-persk bukrs = ls_kapa-bukrs
*      TRANSPORTING NO FIELDS.
*
*      IF sy-subrc = 0.
      CLEAR: ls_check_vormonat.
      READ TABLE gt_vsi INTO ls_check_vormonat
        WITH KEY pernr = ls_vsi-pernr.
      IF sy-subrc NE 0.

        READ TABLE gt_comparison into ls_comparison with key plans = ls_vsi-plans.
                MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        MOVE lv_domtext TO ls_employees-category.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.
        ls_employees-plansid = ls_comparison-plans.
        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-pernr = ls_vsi-pernr.
        ls_employees-employeelistid = ls_vsi-pernr.
        ls_employees-istkapa = ls_vsi-kapa.
        ls_employees-firstname = ls_vsi-vorna.
        ls_employees-lastname = ls_vsi-nachn.
        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa - ls_employees-istkapa.
        ADD ls_vsi-kapa TO gv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        APPEND ls_employees TO lt_employees.
      ENDIF.
*      ENDIF.
      CLEAR: ls_vsi, ls_employees.
    ENDLOOP.



  ELSEIF iv_row_id = 31. " Abweichung von Normkapazität

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.

      IF sy-subrc = 0.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        MOVE lv_domtext TO ls_employees-category.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.
        ls_employees-plansid = ls_comparison-plans.
        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-pernr = ls_vsi-pernr.
        ls_employees-employeelistid = ls_vsi-pernr.
        ls_employees-istkapa = ls_vsi-kapa.
        ls_employees-firstname = ls_vsi-vorna.
        ls_employees-lastname = ls_vsi-nachn.
        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa - ls_employees-istkapa.
        ADD ls_vsi-kapa TO gv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext, ls_vsi, ls_employees, ls_comparison, lv_menge_tmp.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    CLEAR: ls_employees.
    ls_employees-planstext = 'Gesamt'.
    ls_employees-pernr = '99999999'.
    ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
    ls_employees-istkapa = gv_sum_vsi.

    IF lv_menge = 0.
      ls_employees-rechnoffenkapa = '0.0'.
    ELSE.
      ls_employees-rechnoffenkapa = lv_menge.
    ENDIF.

    APPEND ls_employees TO lt_employees.
    CLEAR: ls_employees.


  ELSEIF iv_row_id = 32. " Offen - ohne Aktion

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison
      WHERE gen_kap NE '0,0' AND bes_sta = 1.

      CLEAR: ls_vsi.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.
      IF sy-subrc <> 0. " offen, nicht besetzt

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.

        ls_employees-plansid = ls_comparison-plans.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-category = ls_comparison-bes_sta.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        MOVE lv_domtext TO ls_employees-category.

        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa.
        ls_employees-istkapa = '0.0'.

        IF ls_employees-rechnoffenkapa = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext.
        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: ls_comparison, ls_vsi.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    DESCRIBE TABLE lt_employees LINES lv_lines.
    IF lv_lines > 0.
      CLEAR: ls_employees.
      ls_employees-planstext = 'Gesamt'.
      ls_employees-pernr = '99999999'.
      ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
      ls_employees-istkapa = gv_sum_vsi.
      ls_employees-rechnoffenkapa = lv_menge.
      APPEND ls_employees TO lt_employees.
      CLEAR: ls_employees.
    ENDIF.
    CLEAR: lv_lines.


  ELSEIF iv_row_id = 33. " Offen - ohne Aktion Besetzung genehmigt

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison
    WHERE gen_kap NE '0,0' AND bes_sta = 1
    AND bes_gen = abap_true.

      CLEAR: ls_vsi.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.
      IF sy-subrc <> 0. " offen, nicht besetzt

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.

        ls_employees-plansid = ls_comparison-plans.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-category = ls_comparison-bes_sta.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        MOVE lv_domtext TO ls_employees-category.

        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa.
        ls_employees-istkapa = '0.0'.

        IF ls_employees-rechnoffenkapa = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext.
        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: ls_comparison, ls_vsi.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    DESCRIBE TABLE lt_employees LINES lv_lines.
    IF lv_lines > 0.
      CLEAR: ls_employees.
      ls_employees-planstext = 'Gesamt'.
      ls_employees-pernr = '99999999'.
      ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
      ls_employees-istkapa = gv_sum_vsi.
      ls_employees-rechnoffenkapa = lv_menge.
      APPEND ls_employees TO lt_employees.
      CLEAR: ls_employees.
    ENDIF.
    CLEAR: lv_lines.

  ELSEIF iv_row_id = 34. " Offen - ohne Aktion Besetzung nicht genehmigt

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison
    WHERE gen_kap NE '0,0' AND bes_sta = 1
    AND bes_gen = abap_false.

      CLEAR: ls_vsi.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.
      IF sy-subrc <> 0. " offen, nicht besetzt

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.

        ls_employees-plansid = ls_comparison-plans.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-category = ls_comparison-bes_sta.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        MOVE lv_domtext TO ls_employees-category.

        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa.
        ls_employees-istkapa = '0.0'.

        IF ls_employees-rechnoffenkapa = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext.
        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: ls_comparison, ls_vsi.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    DESCRIBE TABLE lt_employees LINES lv_lines.
    IF lv_lines > 0.
      CLEAR: ls_employees.
      ls_employees-planstext = 'Gesamt'.
      ls_employees-pernr = '99999999'.
      ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
      ls_employees-istkapa = gv_sum_vsi.
      ls_employees-rechnoffenkapa = lv_menge.
      APPEND ls_employees TO lt_employees.
      CLEAR: ls_employees.
    ENDIF.
    CLEAR: lv_lines.


  ELSEIF iv_row_id = 35. " Offen - Suche läuft

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison
    WHERE gen_kap NE '0,0' AND bes_sta = 2.

      CLEAR: ls_vsi.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.
      IF sy-subrc <> 0. " offen, nicht besetzt

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.

        ls_employees-plansid = ls_comparison-plans.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-category = ls_comparison-bes_sta.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        MOVE lv_domtext TO ls_employees-category.

        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa.
        ls_employees-istkapa = '0.0'.

        IF ls_employees-rechnoffenkapa = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext.
        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: ls_comparison, ls_vsi.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    DESCRIBE TABLE lt_employees LINES lv_lines.
    IF lv_lines > 0.
      CLEAR: ls_employees.
      ls_employees-planstext = 'Gesamt'.
      ls_employees-pernr = '99999999'.
      ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
      ls_employees-istkapa = gv_sum_vsi.
      ls_employees-rechnoffenkapa = lv_menge.
      APPEND ls_employees TO lt_employees.
      CLEAR: ls_employees.
    ENDIF.
    CLEAR: lv_lines.

  ELSEIF iv_row_id = 36. "  Offen - Suche abgeschlossen

    CLEAR: gv_sum_max_gen_kapa, gv_sum_vsi, lv_menge.

    " Single Lines
    LOOP AT gt_comparison INTO ls_comparison
    WHERE gen_kap NE '0,0' AND bes_sta = 3.

      CLEAR: ls_vsi.

      READ TABLE gt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.
      IF sy-subrc <> 0. " offen, nicht besetzt

        ADD ls_comparison-gen_kap TO gv_sum_max_gen_kapa.

        ls_employees-plansid = ls_comparison-plans.

        CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
          EXPORTING
            im_plvar = gv_plvar
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-maxgenkapa = ls_comparison-gen_kap.
        ls_employees-category = ls_comparison-bes_sta.

        MOVE ls_comparison-bes_sta TO lv_domvalue.

        CALL FUNCTION 'DOMAIN_VALUE_GET'
          EXPORTING
            i_domname  = 'ZMHP_KAPATOOL_D_BES_STA'
            i_domvalue = lv_domvalue
          IMPORTING
            e_ddtext   = lv_domtext
          EXCEPTIONS
            not_exist  = 1
            OTHERS     = 2.

        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        MOVE lv_domtext TO ls_employees-category.

        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa.
        ls_employees-istkapa = '0.0'.

        IF ls_employees-rechnoffenkapa = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext.
        APPEND ls_employees TO lt_employees.

      ENDIF.

      CLEAR: ls_comparison, ls_vsi.
    ENDLOOP.

    " End Line
    IF gv_sum_vsi < gv_sum_max_gen_kapa.
      lv_menge = gv_sum_max_gen_kapa - gv_sum_vsi.
    ELSEIF gv_sum_vsi > gv_sum_max_gen_kapa.
      lv_menge = gv_sum_vsi - gv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    DESCRIBE TABLE lt_employees LINES lv_lines.
    IF lv_lines > 0.
      CLEAR: ls_employees.
      ls_employees-planstext = 'Gesamt'.
      ls_employees-pernr = '99999999'.
      ls_employees-maxgenkapa = gv_sum_max_gen_kapa.
      ls_employees-istkapa = gv_sum_vsi.
      ls_employees-rechnoffenkapa = lv_menge.
      APPEND ls_employees TO lt_employees.
      CLEAR: ls_employees.
    ENDIF.
    CLEAR: lv_lines.

  ELSEIF iv_row_id = 37. " Ruhend - Stelle freigehalten




  ELSEIF iv_row_id = 38. " Temporärer Überhang



  ELSEIF iv_row_id = 39. " Doppelbesetzung



  ELSEIF iv_row_id = 40. " Überhangstelle


  ENDIF.

**********************************************************************
* Rückgabetabelle setzen
**********************************************************************
  REFRESH et_employees.
  APPEND LINES OF lt_employees TO et_employees.

  "Sortierung
  SORT et_employees BY pernr ASCENDING.
  DELETE ADJACENT DUPLICATES FROM et_employees.

  " Gesamtzeile 99999999 Pernr wieder entfernen
  READ TABLE et_employees INTO ls_employees WITH KEY pernr = '99999999'.
  IF sy-subrc = 0.
    ls_employees-pernr = ''.
    MODIFY et_employees FROM ls_employees INDEX sy-tabix.
  ENDIF.
ENDFUNCTION.
