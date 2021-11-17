FUNCTION zmhp_kapatool_get_search.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_PERNR) TYPE  PERNR_D OPTIONAL
*"     VALUE(IV_ORGEH) TYPE  ORGEH OPTIONAL
*"     VALUE(IV_ORGTXT) TYPE  STEXT OPTIONAL
*"     VALUE(IV_SURNAME) TYPE  PAD_VORNA OPTIONAL
*"     VALUE(IV_LSTNAME) TYPE  PAD_NACHN OPTIONAL
*"  EXPORTING
*"     VALUE(ET_EMPLOYEEDATA) TYPE
*"        ZCL_ZHRKAPATOOL_MPC=>TT_EMPLOYEELIST
*"----------------------------------------------------------------------
  CONSTANTS lc_aw_osp TYPE gdstr-wegid VALUE 'O-S-P'.

* Daten
  DATA: lv_pernr    TYPE          bapiemp_ls-pernr,
        lv_surna    TYPE          bapiemp_sc-sur_name,
        lv_lstna    TYPE          bapiemp_sc-lst_name,
        lv_orgtxt   TYPE          stext,
        lv_plvar    TYPE          plvar,
        ls_perdata  LIKE          person,
        ls_pernrlst LIKE          hrobject,
        lt_pernrlst TYPE TABLE OF hrobject,
        lt_pernrs   TYPE TABLE OF swhactor,
        ls_emplist  LIKE          bapiemp_ls,
        lt_emplist  TYPE TABLE OF bapiemp_ls,
        ls_empdata  TYPE          zcl_zhrkapatool_mpc=>ts_employeelist.

* Feldsymbol
  FIELD-SYMBOLS: <lfs_emplist> LIKE bapiemp_ls.
  FIELD-SYMBOLS: <lfs_pernr> LIKE swhactor.

*"----------------------------------------------------------------------
* Input Conversion (Upper Case und Wildcards)
*"----------------------------------------------------------------------
  IF iv_orgtxt IS NOT INITIAL.
    TRANSLATE iv_orgtxt TO UPPER CASE.
    IF iv_orgtxt NA '*'.
      CONCATENATE iv_orgtxt '*' INTO iv_orgtxt.
    ENDIF.
  ENDIF.

  IF iv_surname IS NOT INITIAL.
    TRANSLATE iv_surname TO UPPER CASE.
    IF iv_surname NA '*'.
      CONCATENATE iv_surname '*' INTO iv_surname.
    ENDIF.
  ENDIF.

  IF iv_lstname IS NOT INITIAL.
    TRANSLATE iv_lstname TO UPPER CASE.
    IF iv_lstname NA '*'.
      CONCATENATE iv_lstname '*' INTO iv_lstname.
    ENDIF.
  ENDIF.

  REPLACE 'OE' IN iv_orgtxt WITH 'Ö'.
  REPLACE 'AE' IN iv_orgtxt WITH 'Ä'.
  REPLACE 'UE' IN iv_orgtxt WITH 'Ü'.

  REPLACE 'OE' IN iv_surname WITH 'Ö'.
  REPLACE 'AE' IN iv_surname WITH 'Ä'.
  REPLACE 'UE' IN iv_surname WITH 'Ü'.

  REPLACE 'OE' IN iv_lstname WITH 'Ö'.
  REPLACE 'AE' IN iv_lstname WITH 'Ä'.
  REPLACE 'UE' IN iv_lstname WITH 'Ü'.

*"----------------------------------------------------------------------
* Programmlogik
*"----------------------------------------------------------------------
* Fall 1: Selektion der Personalnummer
  IF iv_pernr IS NOT INITIAL.
    lv_pernr = iv_pernr.
    "Daten zur Personalnummer ermitteln
    CALL FUNCTION 'HR_GET_EMPLOYEE_DATA'
      EXPORTING
        person_id             = lv_pernr
      IMPORTING
        personal_data         = ls_perdata
      EXCEPTIONS
        person_not_found      = 1
        no_active_integration = 2
        OTHERS                = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    "Falls weitere Selektionen gemacht wurden, prüfen ...
    IF iv_orgeh IS NOT INITIAL.
      CHECK iv_orgeh EQ ls_perdata-orgeh.
    ENDIF.
    IF iv_surname IS NOT INITIAL.
      TRANSLATE ls_perdata-vorna TO UPPER CASE.
      CHECK iv_surname EQ ls_perdata-vorna.
    ENDIF.
    IF iv_lstname IS NOT INITIAL.
      TRANSLATE ls_perdata-nachn TO UPPER CASE.
      CHECK iv_lstname EQ ls_perdata-nachn.
    ENDIF.

    PERFORM get_empldata USING lv_pernr
                               iv_orgeh
                               iv_surname
                               iv_lstname
                               ls_perdata
                               ls_emplist
                      CHANGING et_employeedata.
  ELSE.
*   Fall 2: Es wurde keine Personalnummer selektiert, aber
*           mindestens die Orgeinheit
    IF iv_orgeh IS NOT INITIAL.

*     Aktive Planvariante ermitteln
      CALL FUNCTION 'RH_GET_ACTIVE_WF_PLVAR'
        IMPORTING
          act_plvar       = lv_plvar
        EXCEPTIONS
          no_active_plvar = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

*     Personen zur Orgeinheit ermitteln
      CALL FUNCTION 'RH_STRUC_GET'
        EXPORTING
          act_otype       = 'O'
          act_objid       = iv_orgeh
          act_wegid       = lc_aw_osp
          act_plvar       = lv_plvar
          act_begda       = sy-datum
          act_endda       = sy-datum
          act_tflag       = 'X'
          act_vflag       = 'X'
          authority_check = 'X'
        TABLES
          result_tab      = lt_pernrs
        EXCEPTIONS
          no_plvar_found  = 1
          no_entry_found  = 2
          OTHERS          = 3.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

*     lt_pernrlst für folgenden FuBa-Aufruf mit Personalnummern füllen
      LOOP AT lt_pernrs ASSIGNING <lfs_pernr>
                            WHERE otype EQ 'P'.
        ls_pernrlst-plvar = lv_plvar.
        ls_pernrlst-otype = <lfs_pernr>-otype.
        ls_pernrlst-objid = <lfs_pernr>-objid.
        APPEND ls_pernrlst TO lt_pernrlst.
      ENDLOOP.

    ELSE.
*     Fall 3: Es wurde mindestens der OrgText, der Vorname oder
*             der Nachname selektiert
      lv_surna = iv_surname.
      lv_lstna = iv_lstname.
      lv_orgtxt = iv_orgtxt.

      CALL FUNCTION 'HR_EMPLOYEE_SEARCH'
        EXPORTING
          search_date     = sy-datum
          org_seark       = lv_orgtxt
          sur_name_seark  = lv_surna
          lst_name_seark  = lv_lstna
        TABLES
          pernr_list      = lt_pernrlst
        EXCEPTIONS
          no_active_plvar = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDIF.

    "Daten zu Personalnummern im Fall 2 und 3 ermitteln
    CALL FUNCTION 'HR_EMPLOYEE_LIST'
      EXPORTING
        search_date     = sy-datum
      TABLES
        pernr_list      = lt_pernrlst
        employee_list   = lt_emplist
      EXCEPTIONS
        no_active_plvar = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      DELETE ADJACENT DUPLICATES FROM lt_emplist COMPARING pernr.
    ENDIF.

    LOOP AT lt_emplist ASSIGNING <lfs_emplist>.
      CLEAR ls_empdata.

      PERFORM get_empldata USING lv_pernr
                                 iv_orgeh
                                 iv_surname
                                 iv_lstname
                                 ls_perdata
                                 <lfs_emplist>
                        CHANGING et_employeedata.
    ENDLOOP.
  ENDIF.

ENDFUNCTION.

*"----------------------------------------------------------------------
*"Routinen
*"----------------------------------------------------------------------
FORM get_empldata USING iv_pernr   TYPE bapiemp_ls-pernr
                        iv_orgeh   TYPE orgeh
                        iv_surname TYPE pad_vorna
                        iv_lstname TYPE pad_nachn
                        is_perdata LIKE person
                        is_emplist LIKE bapiemp_ls
               CHANGING et_employeedata
                   TYPE zcl_zhrkapatool_mpc=>tt_employeelist.
*"----------------------------------------------------------------------
* Routine zur Ermittlung der Mitarbeiterdaten
*"----------------------------------------------------------------------
* Konstanten
  CONSTANTS lc_kapa_05 TYPE string VALUE '0,5'.
  CONSTANTS lc_kapa_1 TYPE string VALUE '1,0'.

* Daten
  DATA: lv_geschl_txt   TYPE                   ddtext,
        lv_kapa         TYPE                   string,
        lv_switch_leave TYPE                   hrpad_leave_switch,
        lv_leavedate    TYPE                   d,
        lv_slcnd        TYPE                   string,
        ls_p0001        LIKE                   p0001,
        lt_p0001        TYPE TABLE OF          p0001,
        ls_p0002        LIKE                   p0002,
        lt_p0002        TYPE TABLE OF          p0002,
        ls_p0007        LIKE                   p0007,
        lt_p0007        TYPE TABLE OF          p0007,
        lt_leave_dates  TYPE STANDARD TABLE OF hida,
        ls_empdata      TYPE                   zcl_zhrkapatool_mpc=>ts_employeelist,
        lv_short        TYPE                   short_d,
        lv_persk        TYPE                   pktxt.

* Fall 1: Es wurde nur eine Personalnummer selektiert
  IF is_perdata IS NOT INITIAL.
    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = iv_pernr
        infty           = '0001'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0001
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    READ TABLE lt_p0001 INDEX 1 INTO ls_p0001.

    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = iv_pernr
        infty           = '0002'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0002
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    READ TABLE lt_p0002 INDEX 1 INTO ls_p0002.

    CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
      EXPORTING
        im_plvar = '01'
        im_otype = 'O'
*       IM_VIEW_OBJID       =
*       IM_VIEW_KOKRS       =
        im_objid = ls_p0001-orgeh
*       IM_ISTAT = ' '
        im_begda = sy-datum
        im_endda = sy-datum
      IMPORTING
        short    = lv_short
*       LONG     = stext
      EXCEPTIONS
        OTHERS   = 1.

    "Text zum Geschlecht ermitteln
    CALL FUNCTION 'HRWPC_RFC_GESCH_TEXT_GET'
      EXPORTING
        gesch      = is_perdata-gesch
        langu      = sy-langu
      IMPORTING
        gesch_text = lv_geschl_txt.


    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = iv_pernr
        infty           = '0007'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0007
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    " Ermittlung der Kapazitäten
    READ TABLE lt_p0007 INDEX 1 INTO ls_p0007.
    IF ls_p0007-teilk IS NOT INITIAL.
      lv_kapa = lc_kapa_05.
    ELSE.
      lv_kapa = lc_kapa_1.
    ENDIF.

    " Austrittsdatum ermitteln
    CALL FUNCTION 'HR_LEAVE_DATE_CALC'
      EXPORTING
        persnr                 = iv_pernr
        begda                  = sy-datum
*       ENDDA                  = '99991231'
        switch                 = lv_switch_leave
      IMPORTING
        leavingdate            = lv_leavedate
      TABLES
        leaving_dates          = lt_leave_dates[]
      EXCEPTIONS
        leaving_date_not_found = 1
        OTHERS                 = 2.

    SELECT SINGLE ptext FROM t503t INTO lv_persk
      WHERE persk EQ ls_p0001-persk
      AND sprsl EQ sy-langu.

    ls_empdata-pernr      = is_perdata-pernr.
    ls_empdata-titel      = is_perdata-titel.
    ls_empdata-firstname  = ls_p0002-vorna.
    ls_empdata-lastname   = ls_p0002-nachn.
    ls_empdata-fullname   = is_perdata-ename.
    ls_empdata-geschlecht = lv_geschl_txt.
    ls_empdata-orgid      = is_perdata-orgeh.
    ls_empdata-orglong    = is_perdata-orgeh_txt.
    ls_empdata-orgshort   = lv_short.
    ls_empdata-kapa       = lv_kapa.
    ls_empdata-stundenwaz = ls_p0007-wostd.
    ls_empdata-makreis    = lv_persk.
*    ls_empdata-direktindirekt = ls_p0001-yystadi. "E08 aktivieren ###
    IF lv_leavedate IS NOT INITIAL.
      ls_empdata-austrittsdatum = lv_leavedate.
    ENDIF.
    APPEND ls_empdata TO et_employeedata.

* Fall 2/3: Es wurden mehr als eine Personalnummer ermittelt
  ELSEIF is_emplist IS NOT INITIAL.
    CLEAR: lt_p0001[], lt_p0002[], lt_p0007[],
           ls_p0001, ls_p0002, ls_p0007, lv_geschl_txt,
           lv_kapa, lv_leavedate, lt_leave_dates[],
           ls_empdata.

    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = is_emplist-pernr
        infty           = '0001'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0001
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    READ TABLE lt_p0001 INDEX 1 INTO ls_p0001.

    CALL FUNCTION 'HR_HCP_READ_OBJECT_TEXT'
      EXPORTING
        im_plvar = '01'
        im_otype = 'O'
*       IM_VIEW_OBJID       =
*       IM_VIEW_KOKRS       =
        im_objid = ls_p0001-orgeh
*       IM_ISTAT = ' '
        im_begda = sy-datum
        im_endda = sy-datum
      IMPORTING
        short    = lv_short
*       LONG     = stext
      EXCEPTIONS
        OTHERS   = 1.


    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = is_emplist-pernr
        infty           = '0002'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0002
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    READ TABLE lt_p0002 INDEX 1 INTO ls_p0002.

**   Falls die Orgid mit Vorname oder Nachname selektiert
**   wurden, fehlt bisher die Prüfung auf die Namen
*    IF  iv_surname IS NOT INITIAL
*    AND iv_lstname IS NOT INITIAL.
*      TRANSLATE ls_p0002-vorna TO UPPER CASE.
*      TRANSLATE ls_p0002-nachn TO UPPER CASE.
**      CHECK ls_p0002-vorna EQ iv_surname
**        AND ls_p0002-nachn EQ iv_lstname.
*    ELSEIF iv_surname IS NOT INITIAL.
*      TRANSLATE ls_p0002-vorna TO UPPER CASE.
**      CHECK ls_p0002-vorna EQ iv_surname. " Czakaj, 20.10. - passt nicht für Wildcardsearch bspw. *Herb*
*    ELSEIF iv_lstname IS NOT INITIAL.
*      TRANSLATE ls_p0002-nachn TO UPPER CASE.
**      CHECK ls_p0002-nachn EQ iv_lstname. " Czakaj, 20.10. - passt nicht für Wildcardsearch bspw. *Herb*
*    ENDIF.

    "Text zum Geschlecht ermitteln
    CALL FUNCTION 'HRWPC_RFC_GESCH_TEXT_GET'
      EXPORTING
        gesch      = ls_p0002-gesch
        langu      = sy-langu
      IMPORTING
        gesch_text = lv_geschl_txt.


    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = is_emplist-pernr
        infty           = '0007'
        begda           = sy-datum
        endda           = sy-datum
      TABLES
        infty_tab       = lt_p0007
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

*   Ermittlung der Kapazitäten
    READ TABLE lt_p0007 INDEX 1 INTO ls_p0007.
    IF ls_p0007-teilk IS NOT INITIAL.
      lv_kapa = lc_kapa_05.
    ELSE.
      lv_kapa = lc_kapa_1.
    ENDIF.

*   Austrittsdatum ermitteln
    CALL FUNCTION 'HR_LEAVE_DATE_CALC'
      EXPORTING
        persnr                 = is_emplist-pernr
        begda                  = sy-datum
*       ENDDA                  = '99991231'
        switch                 = lv_switch_leave
      IMPORTING
        leavingdate            = lv_leavedate
      TABLES
        leaving_dates          = lt_leave_dates[]
      EXCEPTIONS
        leaving_date_not_found = 1
        OTHERS                 = 2.

    SELECT SINGLE ptext FROM t503t INTO lv_persk
      WHERE persk EQ ls_p0001-persk
      AND sprsl EQ sy-langu.

    ls_empdata-pernr      = is_emplist-pernr.
    ls_empdata-titel      = ls_p0002-titel.
    ls_empdata-firstname  = ls_p0002-vorna.
    ls_empdata-lastname   = ls_p0002-nachn.
    ls_empdata-fullname   = is_emplist-ename.
    ls_empdata-geschlecht = lv_geschl_txt.
    ls_empdata-orgid      = is_emplist-org_id.
    ls_empdata-orglong    = is_emplist-org_text.
    ls_empdata-orgshort   = lv_short.
    ls_empdata-kapa       = lv_kapa.
    ls_empdata-stundenwaz = ls_p0007-wostd.
    ls_empdata-makreis    = lv_persk.
*    ls_empdata-direktindirekt = ls_p0001-yystadi. "E08 aktivieren ###

    IF lv_leavedate IS NOT INITIAL.
      ls_empdata-austrittsdatum = lv_leavedate.
    ENDIF.

    APPEND ls_empdata TO et_employeedata.

  ENDIF.

ENDFORM.


*ENDFUNCTION.
