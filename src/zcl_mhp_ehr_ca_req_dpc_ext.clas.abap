class ZCL_MHP_EHR_CA_REQ_DPC_EXT definition
  public
  inheriting from ZCL_MHP_EHR_CA_REQ_DPC
  create public .

public section.
protected section.

  methods AUTHREQSET_CREATE_ENTITY
    redefinition .
  methods AUTHREQSET_GET_ENTITY
    redefinition .
  methods AUTHREQSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_MHP_EHR_CA_REQ_DPC_EXT IMPLEMENTATION.


  method AUTHREQSET_CREATE_ENTITY.
*
    ER_ENTITY-GUID = cl_system_uuid=>create_uuid_c32_static( ).
*
  endmethod.


  method AUTHREQSET_GET_ENTITY.
    ER_ENTITY-GUID = cl_system_uuid=>create_uuid_c32_static( ).
  endmethod.


  method AUTHREQSET_GET_ENTITYSET.
    DATA: ls_entity TYPE LINE OF ZCL_MHP_EHR_CA_REQ_MPC=>TT_AUTHREQ.
    ls_entity-guid = cl_system_uuid=>create_uuid_c32_static( ).
    APPEND ls_entity TO ET_ENTITYSET.
  endmethod.
ENDCLASS.
