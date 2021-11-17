*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZMHP_KAPATOOL_FU
*   generation date: 16.03.2015 at 08:23:34
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZMHP_KAPATOOL_FU   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
