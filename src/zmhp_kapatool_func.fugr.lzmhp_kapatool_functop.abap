FUNCTION-POOL ZMHP_KAPATOOL_FUNC.           "MESSAGE-ID ..

* INCLUDE LZMHP_KAPATOOL_FUNCD...            " Local class definition

"$ Region Tables
TABLES: objec.
"$ Endregion Tables

"$ Region Constants
CONSTANTS: gc_x           TYPE boolean_flg VALUE 'X',
           gc_fehler(1)   TYPE c VALUE 'F',
           gc_orgeh_mevbw TYPE orgeh VALUE 02002118,
           gc_orgeh_meveu TYPE orgeh VALUE 02002119,
           gc_orgeh_mevl  TYPE orgeh VALUE 02002120,
           gc_orgeh_mevw  TYPE orgeh VALUE 02002121.
"$ Endregion Constants

"$ Region Datendeklaration
DATA: gt_anz                TYPE zmhp_kapatool_t_amo_tim,
      gt_ergebnis           TYPE zmhp_kapatool_t_time,
      gt_vsi_cum            TYPE TABLE OF zhr06_s_kapa,
      gt_vsi                TYPE TABLE OF zhr06_s_kapa,
      gt_vsi_cum_vormonat   TYPE TABLE OF zhr06_s_kapa,
      gt_vsi_vormonat       TYPE TABLE OF zhr06_s_kapa,
      gt_comparison         TYPE zmhp_kapatool_t_comp,
      gv_anzmon             TYPE i,
      gv_okcode             TYPE syucomm,
      gv_no_one_found3      TYPE flag,
      gv_no_one_found2      TYPE flag,
      gv_no_one_found       TYPE flag,
      gv_sum_bedarf         TYPE zmhp_kapatool_men,
      gv_sum_bedarf_dir     TYPE zmhp_kapatool_men,
      gv_sum_bedarf_ang     TYPE zmhp_kapatool_men,
      gv_sum_bedarf_gew     TYPE zmhp_kapatool_men,
      gv_sum_bedarf_gew_ind TYPE zmhp_kapatool_men,
      gv_sum_bedarf_gew_dir TYPE zmhp_kapatool_men,
      gv_sum_max_gen_kapa   TYPE zmhp_kapatool_men,
      gv_sum_vsi            TYPE zmhp_kapatool_men,
      gv_sum_vsi_ang        TYPE zmhp_kapatool_men,
      gv_sum_vsi_gew        TYPE zmhp_kapatool_men,
      gv_sum_vsi_gew_ind    TYPE zmhp_kapatool_men,
      gv_sum_vsi_gew_dir    TYPE zmhp_kapatool_men,
      gv_sum_soll           TYPE zmhp_kapatool_men,
      gv_sum_plan           TYPE zmhp_kapatool_men,
      gv_sum_plan_ang       TYPE zmhp_kapatool_men,
      gv_sum_plan_gew       TYPE zmhp_kapatool_men,
      gv_plvar              TYPE plvar.
"$ Endregion Datendeklaration
