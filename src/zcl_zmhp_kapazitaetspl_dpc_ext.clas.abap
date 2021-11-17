class ZCL_ZMHP_KAPAZITAETSPL_DPC_EXT definition
  public
  inheriting from ZCL_ZMHP_KAPAZITAETSPL_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END
    redefinition .
protected section.

  methods BUCHUNGSKREISSET_GET_ENTITY
    redefinition .
  methods BUCHUNGSKREISSET_GET_ENTITYSET
    redefinition .
  methods CONFIGURATIONSET_GET_ENTITY
    redefinition .
  methods CONFIGURATIONSET_GET_ENTITYSET
    redefinition .
  methods COSTCENTRESET_GET_ENTITY
    redefinition .
  methods COSTCENTRESET_GET_ENTITYSET
    redefinition .
  methods EMPLOYEELISTSET_GET_ENTITY
    redefinition .
  methods EMPLOYEELISTSET_GET_ENTITYSET
    redefinition .
  methods FORECASTSET_GET_ENTITY
    redefinition .
  methods FORECASTSET_GET_ENTITYSET
    redefinition .
  methods LOCATIONDROPDOWN_GET_ENTITY
    redefinition .
  methods LOCATIONDROPDOWN_GET_ENTITYSET
    redefinition .
  methods MASTERDATASET_GET_ENTITY
    redefinition .
  methods MASTERDATASET_GET_ENTITYSET
    redefinition .
  methods ORGEHDROPDOWNSET_GET_ENTITY
    redefinition .
  methods ORGEHDROPDOWNSET_GET_ENTITYSET
    redefinition .
  methods LISTEMPLOYEESSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZMHP_KAPAZITAETSPL_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
*  EXPORTING
*    IT_OPERATION_INFO =
**  CHANGING
**    cv_defer_mode     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IO_DATA_PROVIDER        =
**    it_key_tab              =
**    it_navigation_path      =
*    IO_EXPAND               =
**    io_tech_request_context =
**  IMPORTING
**    er_deep_entity          =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IO_DATA_PROVIDER        =
**    it_key_tab              =
**    it_navigation_path      =
**    io_tech_request_context =
**  IMPORTING
**    er_entity               =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
**  EXPORTING
**    iv_action_name          =
**    it_parameter            =
**    io_tech_request_context =
**  IMPORTING
**    er_data                 =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
**  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
**    it_key_tab              =
**    it_navigation_path      =
**    io_tech_request_context =
**  IMPORTING
**    er_stream               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IO_DATA_PROVIDER        =
**    it_key_tab              =
**    it_navigation_path      =
**    io_tech_request_context =
**  IMPORTING
**    er_entity               =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_BEGIN
*  EXPORTING
*    IT_OPERATION_INFO =
**  CHANGING
**    cv_defer_mode     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_CORE_SRV_RUNTIME~CHANGESET_END
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method BUCHUNGSKREISSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->BUCHUNGSKREISSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method BUCHUNGSKREISSET_GET_ENTITYSET.
    DATA:      lt_result        TYPE         objec_t,
               ls_result        TYPE         objec,
               lv_orgeh         TYPE         orgeh,
               ls_filter        TYPE         /iwbep/s_mgw_select_option,
               lt_select_option TYPE         /iwbep/s_mgw_select_option-select_options,
               ls_select_option LIKE LINE OF lt_select_option,
               ls_entity        TYPE         zcl_zmhp_kapazitaetspl_mpc=>ts_buchungskreis,
               lv_counter       TYPE         i,
               lv_counter_c     TYPE         c.

    TRY.

        CALL FUNCTION 'ZMHP_KAPATOOL_GET_DDB_BUKRS'
          IMPORTING
            et_result = lt_result.

        ls_entity-bukrsid = '0001'.
        ls_entity-bukrs = ''.
        ls_entity-bukrsshort = ''.
        ls_entity-bukrslong = ''.
        APPEND ls_entity TO et_entityset.

        lv_counter = 2.
        LOOP AT lt_result INTO ls_result.
          MOVE lv_counter TO lv_counter_c.

          IF lv_counter < 10.
            CONCATENATE '000' lv_counter_c INTO ls_entity-bukrsid.
          ELSEIF lv_counter < 100.
            CONCATENATE '00' lv_counter_c INTO ls_entity-bukrsid.
          ELSE.
            CONCATENATE '0' lv_counter_c INTO ls_entity-bukrsid.
          ENDIF.

          MOVE lv_counter TO ls_entity-bukrsid.
          MOVE ls_result-objid TO ls_entity-bukrs.
          MOVE ls_result-short TO ls_entity-bukrsshort.
          MOVE ls_result-stext TO ls_entity-bukrslong.
          APPEND ls_entity TO et_entityset.
          ADD 1 TO lv_counter.
          CLEAR: ls_result, ls_entity.
        ENDLOOP.

*        ls_entity-bukrsid = '0001'.
*        ls_entity-bukrs = ''.
*        ls_entity-bukrsshort = ''.
*        ls_entity-bukrslong = ''.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-bukrsid = '0002'.
*        ls_entity-bukrs = '0002'.
*        ls_entity-bukrsshort = 'SAP A.G. (0002)'.
*        ls_entity-bukrslong = 'SAP A.G. (0002)'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-bukrsid = '0007'.
*        ls_entity-bukrs = '0007'.
*        ls_entity-bukrslong = 'TRUMPF (0007)'.
*        ls_entity-bukrsshort = 'TRUMPF (0007)'.
*        APPEND ls_entity TO et_entityset.

      CATCH /iwbep/cx_mgw_busi_exception .
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.

  endmethod.


  method CONFIGURATIONSET_GET_ENTITY.
    TRY.



      CATCH /iwbep/cx_mgw_busi_exception .
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.
  endmethod.


  method CONFIGURATIONSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->CONFIGURATIONSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method COSTCENTRESET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->COSTCENTRESET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method COSTCENTRESET_GET_ENTITYSET.

    DATA:      lt_result        TYPE         objec_t,
               ls_result        TYPE         objec,
               lv_orgeh         TYPE         orgeh,
               ls_filter        TYPE         /iwbep/s_mgw_select_option,
               lt_select_option TYPE         /iwbep/s_mgw_select_option-select_options,
               ls_select_option LIKE LINE OF lt_select_option,
               ls_entity        TYPE         zcl_zmhp_kapazitaetspl_mpc=>ts_costcentre,
               lv_counter       TYPE         i,
               lv_counter_c     TYPE         c.

    TRY.

        CALL FUNCTION 'ZMHP_KAPATOOL_GET_DDB_KOSTL'
          IMPORTING
            et_result = lt_result.

        ls_entity-kostid = '0001'.
        ls_entity-kostshort = ''.
        ls_entity-kostlong = ''.
        APPEND ls_entity TO et_entityset.
        CLEAR: ls_entity.

        lv_counter = 2.
        LOOP AT lt_result INTO ls_result.
          MOVE lv_counter TO lv_counter_c.

          IF lv_counter < 10.
            CONCATENATE '000' lv_counter_c INTO ls_entity-kostid.
          ELSEIF lv_counter < 100.
            CONCATENATE '00' lv_counter_c INTO ls_entity-kostid.
          ELSE.
            CONCATENATE '0' lv_counter_c INTO ls_entity-kostid.
          ENDIF.

          MOVE ls_result-objid TO ls_entity-kost.
          MOVE ls_result-short TO ls_entity-kostshort.
          MOVE ls_result-stext TO ls_entity-kostlong.
          APPEND ls_entity TO et_entityset.
          ADD 1 TO lv_counter.
          CLEAR: ls_result, ls_entity.
        ENDLOOP.

*        ls_entity-kostid = '0001'.
*        ls_entity-kostshort = ''.
*        ls_entity-kostlong = ''.
*        ls_entity-kost = ''.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-kostid = '0002'.
*        ls_entity-kostshort = 'KOSTL 1'.
*        ls_entity-kostlong = 'Kostenstelle 1'.
*        ls_entity-kost = '0001'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-kostid = '0003'.
*        ls_entity-kostshort = 'KOSTL 2'.
*        ls_entity-kostlong = 'Kostenstelle 2'.
*        ls_entity-kost = '0002'.
*        APPEND ls_entity TO et_entityset.

      CATCH /iwbep/cx_mgw_busi_exception .
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.

  endmethod.


  method EMPLOYEELISTSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->EMPLOYEELISTSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method EMPLOYEELISTSET_GET_ENTITYSET.

    DATA:       ls_filter        TYPE         /iwbep/s_mgw_select_option,
                lt_select_option TYPE         /iwbep/s_mgw_select_option-select_options,
                ls_select_option LIKE LINE OF lt_select_option,
                lv_begda         TYPE         begda,
                lv_endda         TYPE         endda,
                lv_orgid         TYPE         orgeh,
                lt_employees     TYPE         zcl_zmhp_kapazitaetspl_mpc=>tt_employeelist,
                ls_employees     TYPE         zcl_zmhp_kapazitaetspl_mpc=>ts_employeelist,
                lv_temp1         TYPE         string,
                lv_temp2         TYPE         string,
                lv_cumulative    TYPE         flag,
                lv_temp_string   TYPE         string,
                lv_editable      TYPE         string,
                lv_row_id        TYPE         i,
                lv_row_id_char   TYPE         string,
                lv_row_title     TYPE         string,
                lv_selmonthyear  TYPE         string,
                lv_bukrs         TYPE         bukrs,
                lv_location      TYPE         string,
                lv_kostl         TYPE         kostl.

    REFRESH: lt_employees, et_entityset.

    IF it_filter_select_options IS NOT INITIAL.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selOrgid'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_orgid.
      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selMonthYear'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_temp_string.
      MOVE ls_select_option-low TO lv_selmonthyear.
      SPLIT lv_temp_string AT '/' INTO lv_temp1 lv_temp2.

      lv_begda(4) = lv_temp2.
      lv_begda+4(2) = lv_temp1.
      lv_begda+6(2) = '01'.

      CALL FUNCTION 'DATE_GET_MONTH_LASTDAY'
        EXPORTING
          i_date = lv_begda
        IMPORTING
          e_date = lv_endda.

      CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
        EXPORTING
          date                      = lv_begda
        EXCEPTIONS
          plausibility_check_failed = 1
          OTHERS                    = 2.

      IF sy-subrc <> 0.
        lv_begda = sy-datum.
      ENDIF.

      CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
        EXPORTING
          date                      = lv_endda
        EXCEPTIONS
          plausibility_check_failed = 1
          OTHERS                    = 2.

      IF sy-subrc <> 0.
        lv_endda = sy-datum.
      ENDIF.

      CLEAR: ls_filter, ls_select_option, lv_temp1, lv_temp2, lv_temp_string.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selCumulative'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_cumulative.

      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selEditable'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_editable.

      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selRowID'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_row_id.
      MOVE lv_row_id TO lv_row_id_char.

      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selRowTitle'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_row_title.

      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selKostl'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_kostl.

      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selBukrs'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_bukrs.

      CLEAR: ls_filter, ls_select_option.

      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'selLocation'.

      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_location.

      CLEAR: ls_filter, ls_select_option.

      if lv_cumulative eq '1'.
         lv_cumulative = abap_true.
      else.
        lv_cumulative = abap_false.
      endif.

      CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_EMP'
        EXPORTING
          iv_orgid     = lv_orgid
          iv_cumulate  = lv_cumulative
          iv_begda     = lv_begda
          iv_endda     = lv_endda
          iv_row_id    = lv_row_id_char
          iv_row_title = lv_row_title
          iv_location  = lv_location
          iv_bukrs     = lv_bukrs
          iv_kostl     = lv_kostl
        IMPORTING
          et_employees = lt_employees.

      IF lt_employees IS NOT INITIAL.

        LOOP AT lt_employees INTO ls_employees.
          ls_employees-selcumulative = lv_cumulative.
          ls_employees-seleditable = lv_editable.
          ls_employees-selmonthyear = lv_selmonthyear.
          ls_employees-selorgid = lv_orgid.
          ls_employees-selrowid = lv_row_id.
          ls_employees-selrowtitle = lv_row_title.
          MODIFY lt_employees FROM ls_employees INDEX sy-tabix.
          CLEAR: ls_employees.
        ENDLOOP.

        APPEND LINES OF lt_employees TO et_entityset.
      ENDIF.
      REFRESH lt_employees.

    ENDIF.

  endmethod.


  method FORECASTSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->FORECASTSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method FORECASTSET_GET_ENTITYSET.

    DATA: lt_return_tab    TYPE         zcl_zmhp_kapazitaetspl_mpc=>tt_forecast,
          ls_filter        TYPE         /iwbep/s_mgw_select_option,
          lt_select_option TYPE         /iwbep/s_mgw_select_option-select_options,
          ls_select_option LIKE LINE OF lt_select_option,
          lv_orgeh         TYPE         orgeh,
          lv_bukrs         TYPE         bukrs,
          lv_location      TYPE         string,
          lv_kostl         TYPE         kostl,
          lv_begda         TYPE         begda,
          lv_endda         TYPE         endda,
          lv_cumulative    TYPE         flag,
          lv_pernr         TYPE         p0105-pernr,
          lv_usrid         TYPE         p0105-usrid,
          lt_p0001         TYPE         p0001_tab,
          ls_p0001         TYPE         p0001.

    REFRESH: lt_return_tab.

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

    READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Class'.
    READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.

    IF ls_select_option-low EQ 'Visual'.

*     CLEAR: ls_select_option, ls_filter.
*     READ TABLE it_filter_select_options INTO ls_filter
*     WITH KEY property = 'Backup01'.

*     IF sy-subrc <> 0.
        CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_GRAPHIC'
          IMPORTING
            et_table = et_entityset.
*     ENDIF.

    ELSE.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionBegda'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_begda.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionEndda'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_endda.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionCumulative'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_cumulative.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionOrgeh'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_orgeh.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionBukrs'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_bukrs.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionLocation'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_location.

      CLEAR: ls_select_option, ls_filter.
      READ TABLE it_filter_select_options INTO ls_filter
      WITH KEY property = 'SelectionKostl'.
      READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
      MOVE ls_select_option-low TO lv_kostl.

      IF lv_orgeh EQ '99999999' OR lv_orgeh EQ 99999999. " initialer Aufruf, eigene Orgeh lesen
        IF lv_pernr IS NOT INITIAL.
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
            MOVE ls_p0001-orgeh TO lv_orgeh.
          ENDIF.
        ENDIF.

        CLEAR: ls_p0001, lv_usrid.
        REFRESH: lt_p0001.

      ENDIF.

      IF lv_bukrs EQ 'unde'.
        CLEAR: lv_bukrs.
      ENDIF.

      IF lv_location EQ 'unde' OR lv_location EQ 'undefined' OR lv_location EQ 1.
        CLEAR: lv_location.
      ENDIF.

      IF lv_kostl EQ 'undefin' OR lv_kostl EQ 'undefined' OR lv_kostl EQ 1.
        CLEAR: lv_kostl.
      ENDIF.

      IF lv_orgeh EQ 1.
        CLEAR: lv_orgeh.
      ENDIF.

      CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_TABLE'
        EXPORTING
          iv_pernr      = lv_pernr
          iv_begda      = lv_begda
          iv_endda      = lv_endda
          iv_cumulative = lv_cumulative
          iv_orgeh      = lv_orgeh
          iv_bukrs      = lv_bukrs
          iv_location   = lv_location
          iv_kostl      = lv_kostl
        IMPORTING
          et_table      = et_entityset.

    ENDIF.

    CLEAR: lv_pernr.
  endmethod.


  METHOD listemployeesset_get_entityset.
************************************************************************
* Methodenname...............:  listemployeesset_get_entityset         *
* Autor......................:                                         *
* Firma......................:  MHP                                    *
* Projekt....................:                                         *
* Aufgabe....................:                                         *
* Ansprechpartner Fachabt....:                                         *
* Erstellt am................:                                         *
* Kopiert von................:                                         *
* Online/Batch/USER-EXIT ....:  Online                                 *
* Funktionsbeschreibung .....:                                         *
*                                                                      *
*                                                                      *
*                                                                      *
*----------------------------------------------------------------------*
*& Änderungen:                                                         *
*&                                                                     *
*----------------------------------------------------------------------*
*& "SR20150320 - Erweiterung um Filteroptionen                         *
*&                                                                     *
*&---------------------------------------------------------------------*
*& "SR20150320 - Erweiterung um Gehaltsbereich                         *
*&                                                                     *
*&---------------------------------------------------------------------*
    DATA: ls_employees        LIKE          LINE OF et_entityset,
          lt_vsi              TYPE          zmhp_kapatool_t_kapa,
          ls_vsi              LIKE          LINE OF lt_vsi,
          lt_comparison       TYPE          zmhp_kapatool_t_comp,
          ls_comparison       LIKE          LINE OF lt_comparison,
          lv_sum_max_gen_kapa TYPE          zmhp_kapatool_men,
          lv_sum_vsi          TYPE          zmhp_kapatool_men,
          lv_long             TYPE          stext,
          lv_domvalue         TYPE          dd07v-domvalue_l,
          lv_domtext          TYPE          dd07v-ddtext,
          lv_menge            TYPE          zmhp_kapatool_men,
          lv_menge_tmp        TYPE          zmhp_kapatool_men,
          lv_lines            TYPE          i,
          lv_short            TYPE          short_d,
          lv_pernr_emp        TYPE pernr_d,
          lt_p0008            TYPE p0008_tab,
          ls_p0008            TYPE p0008,
          lv_stext            TYPE          stext,
          lv_salaryrange      TYPE          p DECIMALS 2,
          lv_salaryrange_sum  TYPE          p DECIMALS 2.

* begin of SR20150320 - Erweiterung um Filteroptionen
    DATA: ls_filter        TYPE          /iwbep/s_mgw_select_option,
          lt_select_option TYPE          /iwbep/s_mgw_select_option-select_options,
          ls_select_option LIKE LINE OF  lt_select_option,
          lv_orgeh         TYPE          orgeh,
          lv_bukrs         TYPE          bukrs,
          lv_location      TYPE          string,
          lv_kostl         TYPE          kostl,
          lv_begda         TYPE          begda,
          lv_endda         TYPE          endda,
          lv_cumulative    TYPE          flag,
          lv_temp1         TYPE          string,
          lv_temp2         TYPE          string,
          lv_temp_string   TYPE          string,
          lv_selmonthyear  TYPE          string.

    DATA: lv_usrid      TYPE p0105-usrid,
          lv_pernr      TYPE p0105-pernr,
          lt_p0001      TYPE p0001_tab,
          ls_p0001      TYPE p0001,
          lt_result     TYPE TABLE OF swhactor,
          ls_result     TYPE swhactor,
          lv_plvar      TYPE plvar,
          ls_cskt       TYPE cskt,
          lv_kostl_1001 TYPE sobid,
          ls_hrp1000    TYPE hrp1000,
          lt_hrp1000    TYPE TABLE OF hrp1000.


    READ TABLE it_filter_select_options INTO ls_filter
     WITH KEY property = 'selMonthYear'.

    READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
    MOVE ls_select_option-low TO lv_temp_string.
    MOVE ls_select_option-low TO lv_selmonthyear.
    SPLIT lv_temp_string AT '/' INTO lv_temp1 lv_temp2.

    lv_begda(4) = lv_temp2.
    lv_begda+4(2) = lv_temp1.
    lv_begda+6(2) = '01'.

    CALL FUNCTION 'DATE_GET_MONTH_LASTDAY'
      EXPORTING
        i_date = lv_begda
      IMPORTING
        e_date = lv_endda.

    CLEAR: ls_select_option, ls_filter.
    READ TABLE it_filter_select_options INTO ls_filter
    WITH KEY property = 'selCumulative'.
    READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
    MOVE ls_select_option-low TO lv_cumulative.

    CLEAR: ls_select_option, ls_filter.
    READ TABLE it_filter_select_options INTO ls_filter
    WITH KEY property = 'selOrgid'.
    READ TABLE ls_filter-select_options INTO ls_select_option INDEX 1.
    MOVE ls_select_option-low TO lv_orgeh.

    IF lv_orgeh IS INITIAL OR lv_orgeh = '99999999'.

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
        MOVE ls_p0001-orgeh TO lv_orgeh.
        REFRESH lt_p0001.
      ENDIF.

    ENDIF.
*

    IF lv_cumulative EQ 'X' OR lv_cumulative = 1 OR lv_cumulative = '1'.
      lv_cumulative = abap_true.
    ELSE.
      lv_cumulative = abap_false.
    ENDIF.

    CALL FUNCTION 'ZMHP_KAPATOOL_GET_DATA_FROM_SE'
      EXPORTING
*       IV_BUKRS       =
        iv_orgeh       = lv_orgeh
*       IV_LOCATION    =
        iv_begda       = lv_begda
        iv_endda       = lv_endda
        iv_cumulative  = lv_cumulative
        iv_begda_check = lv_begda
        iv_endda_check = lv_endda
*       IV_COSTCENTRE  =
      IMPORTING
        et_vsi         = lt_vsi
        et_comparison  = lt_comparison
*       ET_VSI_VORMONAT       =
      .

    lv_salaryrange = '10000.00'.

    " Single Lines
    LOOP AT lt_comparison INTO ls_comparison.

      READ TABLE lt_vsi INTO ls_vsi WITH KEY plans = ls_comparison-plans.

      IF sy-subrc = 0.

        ADD ls_comparison-gen_kap TO lv_sum_max_gen_kapa.
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
            im_plvar = '01'
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
        ls_employees-austrittsdatum = ls_vsi-austritt.

        IF ls_vsi-austritt IS NOT INITIAL.
          CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
            EXPORTING
              date_internal            = ls_vsi-austritt
            IMPORTING
              date_external            = ls_employees-austrittsdatumext
            EXCEPTIONS
              date_internal_is_invalid = 1
              OTHERS                   = 2.
          IF sy-subrc <> 0.
*   Implement suitable error handling here
          ENDIF.
        ELSE.
          ls_employees-austrittsdatumext = ''.
        ENDIF.

        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-istkapa - ls_employees-maxgenkapa.
        ADD ls_vsi-kapa TO lv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.


        MOVE ls_vsi-pernr TO lv_pernr_emp.
        CALL FUNCTION 'HR_READ_INFOTYPE'
          EXPORTING
*           TCLAS           = 'A'
            pernr           = lv_pernr_emp
            infty           = '0008'
            begda           = sy-datum
            endda           = sy-datum
*           BYPASS_BUFFER   = ' '
*           LEGACY_MODE     = ' '
* IMPORTING
*           SUBRC           =
          TABLES
            infty_tab       = lt_p0008
          EXCEPTIONS
            infty_not_found = 1
            OTHERS          = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        READ TABLE lt_p0008 INTO ls_p0008 INDEX 1.
        MOVE ls_p0008-bet01 TO ls_employees-salaryrange.
        ADD ls_p0008-bet01 TO lv_salaryrange_sum.
        REFRESH lt_p0008.
        CLEAR: ls_p0008.

        ls_employees-class = 'Standard'.
        ls_employees-fontclass = 'Default'.

        IF ls_employees-rechnoffenkapa CS '0.5'
          OR ls_employees-rechnoffenkapa CS '0.6'
          OR ls_employees-rechnoffenkapa CS '0.7'
          OR ls_employees-rechnoffenkapa CS '0.8'
          OR ls_employees-rechnoffenkapa CS '0.9'
          OR ls_employees-rechnoffenkapa CS '1.0'
          OR ls_employees-rechnoffenkapa CS '1.1'
          OR ls_employees-rechnoffenkapa CS '0.5-'
          OR ls_employees-rechnoffenkapa CS '0.6-'
          OR ls_employees-rechnoffenkapa CS '0.7-'
          OR ls_employees-rechnoffenkapa CS '0.8-'
          OR ls_employees-rechnoffenkapa CS '0.9-'
          OR ls_employees-rechnoffenkapa CS '1.0-'
          OR ls_employees-rechnoffenkapa CS '1.1-'.

          ls_employees-fontclass = 'Negative'.


        ENDIF.

        APPEND ls_employees TO et_entityset.

      ELSE. " leere Planstellen wg. max Kapa mit aufnehmen

        ADD ls_comparison-gen_kap TO lv_sum_max_gen_kapa.
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
            im_plvar = '01'
            im_otype = 'S'
            im_objid = ls_comparison-plans
            im_begda = sy-datum
            im_endda = sy-datum
          IMPORTING
            short    = lv_short
            long     = lv_long.

        CONCATENATE lv_long '(' INTO ls_employees-planstext SEPARATED BY space.
        CONCATENATE ls_employees-planstext lv_short ')' INTO ls_employees-planstext.

        ls_employees-orgshort = ls_vsi-orgshort.
        lv_menge_tmp = ls_employees-maxgenkapa - ls_employees-istkapa. " needed for calc of 0 value
        ls_employees-rechnoffenkapa = ls_employees-maxgenkapa - ls_employees-istkapa.
        ADD ls_vsi-kapa TO lv_sum_vsi.

        IF lv_menge_tmp = 0.
          ls_employees-rechnoffenkapa = '0.0'.
        ENDIF.

        ls_employees-class = 'Standard'.
        ls_employees-fontclass = 'Default'.

        IF ls_employees-rechnoffenkapa CS '0.5'
          OR ls_employees-rechnoffenkapa CS '0.6'
          OR ls_employees-rechnoffenkapa CS '0.7'
          OR ls_employees-rechnoffenkapa CS '0.8'
          OR ls_employees-rechnoffenkapa CS '0.9'
          OR ls_employees-rechnoffenkapa CS '1.0'
          OR ls_employees-rechnoffenkapa CS '1.1'
          OR ls_employees-rechnoffenkapa CS '0.5-'
          OR ls_employees-rechnoffenkapa CS '0.6-'
          OR ls_employees-rechnoffenkapa CS '0.7-'
          OR ls_employees-rechnoffenkapa CS '0.8-'
          OR ls_employees-rechnoffenkapa CS '0.9-'
          OR ls_employees-rechnoffenkapa CS '1.0-'
          OR ls_employees-rechnoffenkapa CS '1.1-'.

          ls_employees-fontclass = 'Negative'.

        ENDIF.

*          REPLACE '-' in ls_employees-rechnoffenkapa with ''.
*          IF sy-subrc = 0.
*          CONCATENATE '-' ls_employees-rechnoffenkapa into ls_employees-rechnoffenkapa.
*          endif.

        APPEND ls_employees TO et_entityset.

      ENDIF.

      CLEAR: lv_short, lv_long, lv_domvalue, lv_domtext, ls_vsi, ls_employees, ls_comparison, lv_menge_tmp.
    ENDLOOP.

    " End Line
    IF lv_sum_vsi < lv_sum_max_gen_kapa.
      lv_menge = lv_sum_max_gen_kapa - lv_sum_vsi.


    ELSEIF lv_sum_vsi > lv_sum_max_gen_kapa.
      lv_menge = lv_sum_vsi - lv_sum_max_gen_kapa.
    ELSE.
      lv_menge = 0.
    ENDIF.

    CLEAR: ls_employees.
    "ls_employees-planstext =
    ls_employees-pernr = 'Gesamt'.

    ls_employees-class = 'Bold'.
    ls_employees-fontclass = 'Default'.


    ls_employees-maxgenkapa = lv_sum_max_gen_kapa.
    ls_employees-istkapa = lv_sum_vsi.

    IF lv_menge = 0.
      ls_employees-rechnoffenkapa = '0.0'.
    ELSE.
      ls_employees-rechnoffenkapa = lv_menge.
    ENDIF.

    IF ls_employees-rechnoffenkapa CS '0.5'
      OR ls_employees-rechnoffenkapa CS '0.6'
      OR ls_employees-rechnoffenkapa CS '0.7'
      OR ls_employees-rechnoffenkapa CS '0.8'
      OR ls_employees-rechnoffenkapa CS '0.9'
      OR ls_employees-rechnoffenkapa CS '1.0'
      OR ls_employees-rechnoffenkapa CS '1.1'
      OR ls_employees-rechnoffenkapa CS '0.5-'
      OR ls_employees-rechnoffenkapa CS '0.6-'
      OR ls_employees-rechnoffenkapa CS '0.7-'
      OR ls_employees-rechnoffenkapa CS '0.8-'
      OR ls_employees-rechnoffenkapa CS '0.9-'
      OR ls_employees-rechnoffenkapa CS '1.0-'
      OR ls_employees-rechnoffenkapa CS '1.1-'
            OR ls_employees-rechnoffenkapa CS '2.6'
      OR ls_employees-rechnoffenkapa CS '2.7'
      OR ls_employees-rechnoffenkapa CS '2.4'
      OR ls_employees-rechnoffenkapa CS '2.3'
      OR ls_employees-rechnoffenkapa CS '2.2'
      OR ls_employees-rechnoffenkapa CS '2.0'
      OR ls_employees-rechnoffenkapa CS '2.5-'
      OR ls_employees-rechnoffenkapa CS '2.6-'
      OR ls_employees-rechnoffenkapa CS '2.7-'
      OR ls_employees-rechnoffenkapa CS '2.4-'
      OR ls_employees-rechnoffenkapa CS '2.3-'
      OR ls_employees-rechnoffenkapa CS '2.2-'
      OR ls_employees-rechnoffenkapa CS '2.1-'.

      ls_employees-fontclass = 'Negative'.
      ls_employees-class = 'Bold'.

    ENDIF.


    "ls_employees-salaryrange = lv_salaryrange_sum.
    CLEAR: ls_employees-salaryrange.

    APPEND ls_employees TO et_entityset.
    CLEAR: ls_employees.



  ENDMETHOD.


  method LOCATIONDROPDOWN_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->LOCATIONDROPDOWN_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method LOCATIONDROPDOWN_GET_ENTITYSET.

    DATA:      lt_result        TYPE         objec_t,
               ls_result        TYPE         objec,
               lv_orgeh         TYPE         orgeh,
               ls_filter        TYPE         /iwbep/s_mgw_select_option,
               lt_select_option TYPE         /iwbep/s_mgw_select_option-select_options,
               ls_select_option LIKE LINE OF lt_select_option,
               ls_entity        TYPE         zcl_zmhp_kapazitaetspl_mpc=>ts_locationdropdown,
               lv_counter       TYPE         i,
               lv_counter_c     TYPE c.

    TRY.

        CALL FUNCTION 'ZMHP_KAPATOOL_GET_DDB_LOC'
          IMPORTING
            et_result = lt_result.

        ls_entity-locationdropdownid = '0001'.
        ls_entity-locationshort = ''.
        ls_entity-locationlong = ''.
        APPEND ls_entity TO et_entityset.

        lv_counter = 2.
        LOOP AT lt_result INTO ls_result.
          MOVE lv_counter TO lv_counter_c.

          IF lv_counter < 10.
            CONCATENATE '000' lv_counter_c INTO ls_entity-locationdropdownid.
          ELSEIF lv_counter < 100.
            CONCATENATE '00' lv_counter_c INTO ls_entity-locationdropdownid.
          ELSE.
            CONCATENATE '0' lv_counter_c INTO ls_entity-locationdropdownid.
          ENDIF.

          MOVE ls_result-short TO ls_entity-locationshort.
          MOVE ls_result-stext TO ls_entity-locationlong.
          APPEND ls_entity TO et_entityset.
          ADD 1 TO lv_counter.
          CLEAR: ls_result, ls_entity.
        ENDLOOP.

*        ls_entity-locationdropdownid = '0001'.
*        ls_entity-locationshort = ''.
*        ls_entity-locationlong = ''.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-locationdropdownid = '0002'.
*        ls_entity-locationshort = 'Stammhaus 1'.
*        ls_entity-locationlong = 'Stamm 1'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-locationdropdownid = '0003'.
*        ls_entity-locationshort = 'Stammhaus 2'.
*        ls_entity-locationlong = 'Stamm 2'.
*        APPEND ls_entity TO et_entityset.


      CATCH /iwbep/cx_mgw_busi_exception .
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.
  endmethod.


  method MASTERDATASET_GET_ENTITY.

    TRY.

        CALL FUNCTION 'ZMHP_KAPATOOL_GET_CONF_MD'
          IMPORTING
            es_masterdata = er_entity.

      CATCH /iwbep/cx_mgw_busi_exception .
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.

  endmethod.


  method MASTERDATASET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->MASTERDATASET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method ORGEHDROPDOWNSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->ORGEHDROPDOWNSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  endmethod.


  method ORGEHDROPDOWNSET_GET_ENTITYSET.

    DATA:      lt_result        TYPE         objec_t,
               ls_result        TYPE         objec,
               lv_orgeh         TYPE         orgeh,
               ls_filter        TYPE         /iwbep/s_mgw_select_option,
               lt_select_option TYPE         /iwbep/s_mgw_select_option-select_options,
               ls_select_option LIKE LINE OF lt_select_option,
               ls_entity        TYPE         zcl_zmhp_kapazitaetspl_mpc=>ts_orgehdropdown,
               lv_counter       TYPE         i,
               lv_counter_c     TYPE c.

    TRY.

        CALL FUNCTION 'ZMHP_KAPATOOL_GET_DDB_ORGEH'
          IMPORTING
            et_result = lt_result.


        ls_entity-orgehdropdownid = '0001'.
        ls_entity-orgshort = ''.
        ls_entity-orglong = ''.
        APPEND ls_entity TO et_entityset.

        lv_counter = 2.
        LOOP AT lt_result INTO ls_result.
          MOVE lv_counter TO lv_counter_c.

          IF lv_counter < 10.
            CONCATENATE '000' lv_counter_c INTO ls_entity-orgehdropdownid.
          ELSEIF lv_counter < 100.
            CONCATENATE '00' lv_counter_c INTO ls_entity-orgehdropdownid.
          ELSE.
            CONCATENATE '0' lv_counter_c INTO ls_entity-orgehdropdownid.
          ENDIF.

          MOVE ls_result-objid TO ls_entity-orgeh.
          MOVE ls_result-short TO ls_entity-orgshort.
          MOVE ls_result-stext TO ls_entity-orglong.
          APPEND ls_entity TO et_entityset.
          ADD 1 TO lv_counter.
          CLEAR: ls_result, ls_entity.
        ENDLOOP.

*        ls_entity-orgehdropdownid = '0002'.
*        ls_entity-orgshort = 'TRUMPF'.
*        ls_entity-orglong = 'Organisation1'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-orgehdropdownid = '0003'.
*        ls_entity-orgshort = 'TH-621'.
*        ls_entity-orglong = 'Organisation2'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-orgehdropdownid = '0004'.
*        ls_entity-orgshort = 'TH-622'.
*        ls_entity-orglong = 'Organisation3'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-orgehdropdownid = '0005'.
*        ls_entity-orgshort = 'THD-ANS-HR41'.
*        ls_entity-orglong = 'Organisation4'.
*        APPEND ls_entity TO et_entityset.
*
*        ls_entity-orgehdropdownid = '0006'.
*        ls_entity-orgshort = 'THD-ANS-HR42'.
*        ls_entity-orglong = 'Organisation5'.
*        APPEND ls_entity TO et_entityset.

      CATCH /iwbep/cx_mgw_busi_exception .
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.

  endmethod.
ENDCLASS.
