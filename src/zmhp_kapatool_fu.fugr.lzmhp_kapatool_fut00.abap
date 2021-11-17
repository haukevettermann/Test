*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZMHP_KAPATOOL_KP................................*
DATA:  BEGIN OF STATUS_ZMHP_KAPATOOL_KP              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZMHP_KAPATOOL_KP              .
CONTROLS: TCTRL_ZMHP_KAPATOOL_KP
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZMHP_KAPATOOL_KP              .
TABLES: ZMHP_KAPATOOL_KP               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
