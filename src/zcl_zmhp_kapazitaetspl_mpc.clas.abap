class ZCL_ZMHP_KAPAZITAETSPL_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element. .
  types:
  begin of TS_ORGEHDROPDOWN,
     BACKUP04 type string,
     BACKUP03 type string,
     BACKUP02 type string,
     BACKUP01 type string,
     ORGLONG type string,
     ORGSHORT type string,
     ORGEH type string,
     ORGEHDROPDOWNID type string,
  end of TS_ORGEHDROPDOWN. .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol. .
  types:
TT_ORGEHDROPDOWN type standard table of TS_ORGEHDROPDOWN. .
  types:
  begin of TS_EMPLOYEELIST,
     EMPLOYEELISTID type string,
     FIRSTNAME type string,
     LASTNAME type string,
     FULLNAME type string,
     ORGID type string,
     ORGSHORT type string,
     ORGLONG type string,
     PERNR type string,
     KAPA type string,
     STUNDENWAZ type string,
     MAKREIS type string,
     DIREKTINDIREKT type string,
     GESCHLECHT type string,
     AUSTRITTSDATUM type string,
     TITEL type string,
     BACKUP01 type string,
     BACKUP02 type string,
     BACKUP03 type string,
     BACKUP04 type string,
     SELORGID type string,
     SELMONTHYEAR type string,
     SELCUMULATIVE type string,
     SELANU type string,
     SELEDITABLE type string,
     SELROWID type string,
     SELROWTITLE type string,
     KOMMENTAR type string,
     BACKUP01TEXT type string,
     KOMMENTARLINK type string,
     ABGRENZDATUM type string,
     VERLANGERMONATE type string,
     BACKUP02TEXT type string,
     AUSTRITTSDATUMEXT type string,
     RESPONSEMESSAGE type string,
     SELBUKRS type string,
     SELKOSTL type string,
     SELLOCATION type string,
     PLANSID type string,
     PLANSTEXT type string,
     MAXGENKAPA type string,
     ISTKAPA type string,
     CATEGORY type string,
     RECHNOFFENKAPA type string,
     CLASS type string,
     FONTCLASS type string,
  end of TS_EMPLOYEELIST. .
  types:
TT_EMPLOYEELIST type standard table of TS_EMPLOYEELIST. .
  types:
  begin of TS_FORECAST,
     KPIBACKUP01 type string,
     KPIBACKUP02 type string,
     KPIID type string,
     KPITEXT type string,
     FORECASTID type string,
     TITLE type string,
     MON01 type string,
     MON02 type string,
     MON03 type string,
     MON04 type string,
     MON05 type string,
     MON06 type string,
     MON07 type string,
     MON08 type string,
     MON09 type string,
     MON10 type string,
     MON11 type string,
     MON12 type string,
     MON13 type string,
     MON14 type string,
     MON15 type string,
     MON16 type string,
     MON17 type string,
     MON18 type string,
     MON19 type string,
     MON20 type string,
     MON21 type string,
     MON22 type string,
     MON23 type string,
     MON24 type string,
     VISIBLE type string,
     EDITABLE type FLAG,
     PARENTID type string,
     CHILDID type string,
     ISLINK type FLAG,
     ISTEXT type FLAG,
     CLASS type string,
     FONTCLASS type string,
     BACKUP01 type string,
     BACKUP02 type string,
     BACKUP03 type string,
     BACKUP04 type string,
     TOOLTIP type string,
     KPILONGTEXT type string,
     RESPONSEMESSAGE type string,
     SELECTIONBEGDA type string,
     SELECTIONENDDA type string,
     SELECTIONCUMULATIVE type string,
     SELECTIONBUKRS type string,
     SELECTIONORGEH type string,
     SELECTIONLOCATION type string,
     SELECTIONKOSTL type string,
  end of TS_FORECAST. .
  types:
TT_FORECAST type standard table of TS_FORECAST. .
  types:
  begin of TS_MASTERDATA,
     MASTERDATAID type string,
     USERNAME type string,
     USERORGUNIT type string,
     USERPERNR type string,
     USERROLE type string,
     USERLANGUAGE type string,
  end of TS_MASTERDATA. .
  types:
TT_MASTERDATA type standard table of TS_MASTERDATA. .
  types:
  begin of TS_CONFIGURATION,
     CONFIGURATIONID type string,
     BEGDA type string,
     ENDDA type string,
     CUMULATIVE type string,
     ORGEH type string,
     BUKRS type string,
     KOSTL type string,
  end of TS_CONFIGURATION. .
  types:
TT_CONFIGURATION type standard table of TS_CONFIGURATION. .
  types:
  begin of TS_BUCHUNGSKREIS,
     BACKUP04 type string,
     BACKUP03 type string,
     BACKUP02 type string,
     BACKUP01 type string,
     BUKRSLONG type string,
     BUKRSSHORT type string,
     BUKRS type string,
     BUKRSID type string,
  end of TS_BUCHUNGSKREIS. .
  types:
TT_BUCHUNGSKREIS type standard table of TS_BUCHUNGSKREIS. .
  types:
  begin of TS_COSTCENTRE,
     BACKUP04 type string,
     BACKUP03 type string,
     BACKUP02 type string,
     BACKUP01 type string,
     KOSTLONG type string,
     KOSTSHORT type string,
     KOST type string,
     KOSTID type string,
  end of TS_COSTCENTRE. .
  types:
TT_COSTCENTRE type standard table of TS_COSTCENTRE. .
  types:
  begin of TS_LOCATIONDROPDOWN,
     BACKUP04 type string,
     BACKUP03 type string,
     BACKUP02 type string,
     BACKUP01 type string,
     LOCATIONDROPDOWNID type string,
     LOCATIONLONG type string,
     LOCATIONSHORT type string,
  end of TS_LOCATIONDROPDOWN. .
  types:
TT_LOCATIONDROPDOWN type standard table of TS_LOCATIONDROPDOWN. .
  types:
  begin of TS_LISTEMPLOYEES,
     EMPLOYEELISTID type string,
     FIRSTNAME type string,
     LASTNAME type string,
     FULLNAME type string,
     ORGID type string,
     ORGSHORT type string,
     ORGLONG type string,
     PERNR type string,
     KAPA type string,
     STUNDENWAZ type string,
     MAKREIS type string,
     DIREKTINDIREKT type string,
     GESCHLECHT type string,
     AUSTRITTSDATUM type string,
     TITEL type string,
     BACKUP01 type string,
     BACKUP02 type string,
     BACKUP03 type string,
     BACKUP04 type string,
     SELORGID type string,
     SELMONTHYEAR type string,
     SELCUMULATIVE type string,
     SELANU type string,
     SELEDITABLE type string,
     SELROWID type string,
     SELROWTITLE type string,
     KOMMENTAR type string,
     BACKUP01TEXT type string,
     KOMMENTARLINK type string,
     ABGRENZDATUM type string,
     VERLANGERMONATE type string,
     BACKUP02TEXT type string,
     AUSTRITTSDATUMEXT type string,
     RESPONSEMESSAGE type string,
     SELBUKRS type string,
     SELKOSTL type string,
     SELLOCATION type string,
     PLANSID type string,
     PLANSTEXT type string,
     MAXGENKAPA type string,
     ISTKAPA type string,
     CATEGORY type string,
     SALARYRANGE type string,
     RECHNOFFENKAPA type string,
     CLASS type string,
     FONTCLASS type string,
  end of TS_LISTEMPLOYEES. .
  types:
TT_LISTEMPLOYEES type standard table of TS_LISTEMPLOYEES. .

  constants GC_BUCHUNGSKREIS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'BuchungsKreis' ##NO_TEXT.
  constants GC_CONFIGURATION type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Configuration' ##NO_TEXT.
  constants GC_COSTCENTRE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'CostCentre' ##NO_TEXT.
  constants GC_EMPLOYEELIST type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'EmployeeList' ##NO_TEXT.
  constants GC_FORECAST type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Forecast' ##NO_TEXT.
  constants GC_LISTEMPLOYEES type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ListEmployees' ##NO_TEXT.
  constants GC_LOCATIONDROPDOWN type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'LocationDropdown' ##NO_TEXT.
  constants GC_MASTERDATA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'MasterData' ##NO_TEXT.
  constants GC_ORGEHDROPDOWN type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'OrgehDropdown' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  constants GC_INCL_NAME type STRING value 'ZCL_ZMHP_KAPAZITAETSPL_MPC====CP' ##NO_TEXT.

  methods DEFINE_ORGEHDROPDOWN
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_EMPLOYEELIST
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_FORECAST
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_MASTERDATA
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_CONFIGURATION
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_BUCHUNGSKREIS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_COSTCENTRE
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_LOCATIONDROPDOWN
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_LISTEMPLOYEES
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_ACTIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZMHP_KAPAZITAETSPL_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'ZHR06_KAPATOOL_SRV' ).

define_orgehdropdown( ).
define_employeelist( ).
define_forecast( ).
define_masterdata( ).
define_configuration( ).
define_buchungskreis( ).
define_costcentre( ).
define_locationdropdown( ).
define_listemployees( ).
define_actions( ).
  endmethod.


  method DEFINE_ACTIONS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
lo_action         type ref to /iwbep/if_mgw_odata_action,                 "#EC NEEDED
lo_parameter      type ref to /iwbep/if_mgw_odata_parameter.              "#EC NEEDED

***********************************************************************************************************************************
*   ACTION - GetEmployeeSearch
***********************************************************************************************************************************

lo_action = model->create_action( 'GetEmployeeSearch' ).  "#EC NOTEXT
*Set return entity type
lo_action->set_return_entity_type( 'EmployeeList' ). "#EC NOTEXT
*Set HTTP method GET or POST
lo_action->set_http_method( 'GET' ). "#EC NOTEXT
* Set return type multiplicity
lo_action->set_return_multiplicity( 'M' ). "#EC NOTEXT
  endmethod.


  method DEFINE_BUCHUNGSKREIS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - BuchungsKreis
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'BuchungsKreis' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'BukrsLong' iv_abap_fieldname = 'BUKRSLONG' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'BukrsShort' iv_abap_fieldname = 'BUKRSSHORT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Bukrs' iv_abap_fieldname = 'BUKRS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'BukrsID' iv_abap_fieldname = 'BUKRSID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_BUCHUNGSKREIS' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'BuchungskreisSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_CONFIGURATION.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - Configuration
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'Configuration' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'ConfigurationID' iv_abap_fieldname = 'CONFIGURATIONID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Begda' iv_abap_fieldname = 'BEGDA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Endda' iv_abap_fieldname = 'ENDDA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Cumulative' iv_abap_fieldname = 'CUMULATIVE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Orgeh' iv_abap_fieldname = 'ORGEH' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Bukrs' iv_abap_fieldname = 'BUKRS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Kostl' iv_abap_fieldname = 'KOSTL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_CONFIGURATION' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'ConfigurationSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_COSTCENTRE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - CostCentre
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'CostCentre' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KostLong' iv_abap_fieldname = 'KOSTLONG' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KostShort' iv_abap_fieldname = 'KOSTSHORT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Kost' iv_abap_fieldname = 'KOST' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KostID' iv_abap_fieldname = 'KOSTID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_COSTCENTRE' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'CostCentreSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_EMPLOYEELIST.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - EmployeeList
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'EmployeeList' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'EmployeeListID' iv_abap_fieldname = 'EMPLOYEELISTID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Firstname' iv_abap_fieldname = 'FIRSTNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Lastname' iv_abap_fieldname = 'LASTNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Fullname' iv_abap_fieldname = 'FULLNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgId' iv_abap_fieldname = 'ORGID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgShort' iv_abap_fieldname = 'ORGSHORT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgLong' iv_abap_fieldname = 'ORGLONG' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Pernr' iv_abap_fieldname = 'PERNR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Kapa' iv_abap_fieldname = 'KAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'StundenWAZ' iv_abap_fieldname = 'STUNDENWAZ' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MaKreis' iv_abap_fieldname = 'MAKREIS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'DirektIndirekt' iv_abap_fieldname = 'DIREKTINDIREKT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Geschlecht' iv_abap_fieldname = 'GESCHLECHT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Austrittsdatum' iv_abap_fieldname = 'AUSTRITTSDATUM' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Titel' iv_abap_fieldname = 'TITEL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selOrgid' iv_abap_fieldname = 'SELORGID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selMonthYear' iv_abap_fieldname = 'SELMONTHYEAR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selCumulative' iv_abap_fieldname = 'SELCUMULATIVE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selAnu' iv_abap_fieldname = 'SELANU' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selEditable' iv_abap_fieldname = 'SELEDITABLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selRowID' iv_abap_fieldname = 'SELROWID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selRowTitle' iv_abap_fieldname = 'SELROWTITLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Kommentar' iv_abap_fieldname = 'KOMMENTAR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01Text' iv_abap_fieldname = 'BACKUP01TEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KommentarLink' iv_abap_fieldname = 'KOMMENTARLINK' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'AbgrenzDatum' iv_abap_fieldname = 'ABGRENZDATUM' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'VerlangerMonate' iv_abap_fieldname = 'VERLANGERMONATE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02Text' iv_abap_fieldname = 'BACKUP02TEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'AustrittsdatumExt' iv_abap_fieldname = 'AUSTRITTSDATUMEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ResponseMessage' iv_abap_fieldname = 'RESPONSEMESSAGE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selBukrs' iv_abap_fieldname = 'SELBUKRS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selKostl' iv_abap_fieldname = 'SELKOSTL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selLocation' iv_abap_fieldname = 'SELLOCATION' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PlansID' iv_abap_fieldname = 'PLANSID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PlansText' iv_abap_fieldname = 'PLANSTEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MaxGenKapa' iv_abap_fieldname = 'MAXGENKAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IstKapa' iv_abap_fieldname = 'ISTKAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Category' iv_abap_fieldname = 'CATEGORY' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'RechnOffenKapa' iv_abap_fieldname = 'RECHNOFFENKAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Class' iv_abap_fieldname = 'CLASS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'FontClass' iv_abap_fieldname = 'FONTCLASS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_EMPLOYEELIST' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'EmployeeListSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_FORECAST.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - Forecast
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'Forecast' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'KpiBackup01' iv_abap_fieldname = 'KPIBACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KpiBackup02' iv_abap_fieldname = 'KPIBACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KpiId' iv_abap_fieldname = 'KPIID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KpiText' iv_abap_fieldname = 'KPITEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ForecastID' iv_abap_fieldname = 'FORECASTID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Title' iv_abap_fieldname = 'TITLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon01' iv_abap_fieldname = 'MON01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon02' iv_abap_fieldname = 'MON02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon03' iv_abap_fieldname = 'MON03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon04' iv_abap_fieldname = 'MON04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon05' iv_abap_fieldname = 'MON05' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon06' iv_abap_fieldname = 'MON06' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon07' iv_abap_fieldname = 'MON07' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon08' iv_abap_fieldname = 'MON08' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon09' iv_abap_fieldname = 'MON09' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon10' iv_abap_fieldname = 'MON10' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon11' iv_abap_fieldname = 'MON11' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon12' iv_abap_fieldname = 'MON12' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon13' iv_abap_fieldname = 'MON13' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon14' iv_abap_fieldname = 'MON14' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon15' iv_abap_fieldname = 'MON15' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon16' iv_abap_fieldname = 'MON16' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon17' iv_abap_fieldname = 'MON17' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon18' iv_abap_fieldname = 'MON18' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon19' iv_abap_fieldname = 'MON19' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon20' iv_abap_fieldname = 'MON20' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon21' iv_abap_fieldname = 'MON21' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon22' iv_abap_fieldname = 'MON22' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon23' iv_abap_fieldname = 'MON23' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Mon24' iv_abap_fieldname = 'MON24' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Visible' iv_abap_fieldname = 'VISIBLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Editable' iv_abap_fieldname = 'EDITABLE' ). "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ParentId' iv_abap_fieldname = 'PARENTID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ChildId' iv_abap_fieldname = 'CHILDID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IsLink' iv_abap_fieldname = 'ISLINK' ). "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IsText' iv_abap_fieldname = 'ISTEXT' ). "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Class' iv_abap_fieldname = 'CLASS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'FontClass' iv_abap_fieldname = 'FONTCLASS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Tooltip' iv_abap_fieldname = 'TOOLTIP' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KpiLongtext' iv_abap_fieldname = 'KPILONGTEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ResponseMessage' iv_abap_fieldname = 'RESPONSEMESSAGE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionBegda' iv_abap_fieldname = 'SELECTIONBEGDA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionEndda' iv_abap_fieldname = 'SELECTIONENDDA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionCumulative' iv_abap_fieldname = 'SELECTIONCUMULATIVE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionBukrs' iv_abap_fieldname = 'SELECTIONBUKRS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionOrgeh' iv_abap_fieldname = 'SELECTIONORGEH' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionLocation' iv_abap_fieldname = 'SELECTIONLOCATION' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SelectionKostl' iv_abap_fieldname = 'SELECTIONKOSTL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_FORECAST' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'ForecastSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_LISTEMPLOYEES.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - ListEmployees
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'ListEmployees' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'EmployeeListID' iv_abap_fieldname = 'EMPLOYEELISTID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Firstname' iv_abap_fieldname = 'FIRSTNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Lastname' iv_abap_fieldname = 'LASTNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Fullname' iv_abap_fieldname = 'FULLNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgId' iv_abap_fieldname = 'ORGID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgShort' iv_abap_fieldname = 'ORGSHORT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgLong' iv_abap_fieldname = 'ORGLONG' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Pernr' iv_abap_fieldname = 'PERNR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Kapa' iv_abap_fieldname = 'KAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'StundenWAZ' iv_abap_fieldname = 'STUNDENWAZ' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MaKreis' iv_abap_fieldname = 'MAKREIS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'DirektIndirekt' iv_abap_fieldname = 'DIREKTINDIREKT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Geschlecht' iv_abap_fieldname = 'GESCHLECHT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Austrittsdatum' iv_abap_fieldname = 'AUSTRITTSDATUM' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Titel' iv_abap_fieldname = 'TITEL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selOrgid' iv_abap_fieldname = 'SELORGID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selMonthYear' iv_abap_fieldname = 'SELMONTHYEAR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selCumulative' iv_abap_fieldname = 'SELCUMULATIVE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selAnu' iv_abap_fieldname = 'SELANU' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selEditable' iv_abap_fieldname = 'SELEDITABLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selRowID' iv_abap_fieldname = 'SELROWID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selRowTitle' iv_abap_fieldname = 'SELROWTITLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Kommentar' iv_abap_fieldname = 'KOMMENTAR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01Text' iv_abap_fieldname = 'BACKUP01TEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'KommentarLink' iv_abap_fieldname = 'KOMMENTARLINK' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'AbgrenzDatum' iv_abap_fieldname = 'ABGRENZDATUM' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'VerlangerMonate' iv_abap_fieldname = 'VERLANGERMONATE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02Text' iv_abap_fieldname = 'BACKUP02TEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'AustrittsdatumExt' iv_abap_fieldname = 'AUSTRITTSDATUMEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ResponseMessage' iv_abap_fieldname = 'RESPONSEMESSAGE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selBukrs' iv_abap_fieldname = 'SELBUKRS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selKostl' iv_abap_fieldname = 'SELKOSTL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'selLocation' iv_abap_fieldname = 'SELLOCATION' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PlansID' iv_abap_fieldname = 'PLANSID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PlansText' iv_abap_fieldname = 'PLANSTEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MaxGenKapa' iv_abap_fieldname = 'MAXGENKAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IstKapa' iv_abap_fieldname = 'ISTKAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Category' iv_abap_fieldname = 'CATEGORY' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SalaryRange' iv_abap_fieldname = 'SALARYRANGE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'RechnOffenKapa' iv_abap_fieldname = 'RECHNOFFENKAPA' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Class' iv_abap_fieldname = 'CLASS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'FontClass' iv_abap_fieldname = 'FONTCLASS' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_LISTEMPLOYEES' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'ListEmployeesSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_LOCATIONDROPDOWN.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - LocationDropdown
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'LocationDropdown' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LocationDropdownID' iv_abap_fieldname = 'LOCATIONDROPDOWNID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LocationLong' iv_abap_fieldname = 'LOCATIONLONG' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LocationShort' iv_abap_fieldname = 'LOCATIONSHORT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_LOCATIONDROPDOWN' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'LocationDropdownSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_MASTERDATA.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - MasterData
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'MasterData' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'MasterDataID' iv_abap_fieldname = 'MASTERDATAID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'UserName' iv_abap_fieldname = 'USERNAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'UserOrgunit' iv_abap_fieldname = 'USERORGUNIT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'UserPernr' iv_abap_fieldname = 'USERPERNR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'UserRole' iv_abap_fieldname = 'USERROLE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'UserLanguage' iv_abap_fieldname = 'USERLANGUAGE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_MASTERDATA' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'MasterDataSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_ORGEHDROPDOWN.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - OrgehDropdown
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'OrgehDropdown' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Backup04' iv_abap_fieldname = 'BACKUP04' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup03' iv_abap_fieldname = 'BACKUP03' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup02' iv_abap_fieldname = 'BACKUP02' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Backup01' iv_abap_fieldname = 'BACKUP01' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgLong' iv_abap_fieldname = 'ORGLONG' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgShort' iv_abap_fieldname = 'ORGSHORT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Orgeh' iv_abap_fieldname = 'ORGEH' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property = lo_entity_type->create_property( iv_property_name = 'OrgehDropdownID' iv_abap_fieldname = 'ORGEHDROPDOWNID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).

lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_ORGEHDROPDOWN' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'OrgehDropdownSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_true ).
lo_entity_set->set_deletable( abap_true ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20150410114711'.                  "#EC NOTEXT
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
     ls_text_element TYPE ts_text_element.                                 "#EC NEEDED
  endmethod.
ENDCLASS.
