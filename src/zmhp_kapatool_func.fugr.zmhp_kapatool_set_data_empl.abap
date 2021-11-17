FUNCTION zmhp_kapatool_set_data_empl.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IS_DATASET) TYPE
*"        ZCL_ZMHP_KAPAZITAETSPL_MPC=>TS_EMPLOYEELIST
*"  EXPORTING
*"     VALUE(EV_SUCCESS) TYPE  SUCCESS_FLAG
*"----------------------------------------------------------------------

  " SAPUI5 sendet Anfragen strukturweise (d.h. zeilenweise).
  " Dazu wird eine Batch-Operation erzeugt, welche Zeile für Zeile sendet
  " d.h. hier muss auf ID bzw. Import-Parameter geprüft werden und
  " die jeweilige Zeile gesichert werde (neue Mitarbeiter)

  IF sy-subrc = 0.
    ev_success = abap_true.
  ENDIF.

  " !! COMMIT WORK AND WAIT

ENDFUNCTION.
