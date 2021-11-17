FUNCTION zmhp_kapatool_get_data_inactiv.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_PERNR) TYPE  PERNR_D
*"     VALUE(IS_P0000) TYPE  P0000
*"     VALUE(IS_P0001) TYPE  P0001
*"  EXPORTING
*"     VALUE(EV_IS_INACTIVE) TYPE  FLAG
*"     VALUE(EV_MIGHT_RETURN) TYPE  FLAG
*"----------------------------------------------------------------------

  DATA: ls_p2001 TYPE p2001,
        lt_p2001 TYPE p2001_tab

        .

  CLEAR: ev_is_inactive, ev_might_return.

  " Testdata !! Thomas Jung
  IF iv_pernr = '00000014'.
    ev_is_inactive = abap_true.
    ev_might_return = abap_true.
    EXIT.
  ENDIF.

  " easy checks - 2DO: customizbar machen
  IF is_p0000-stat2 = 1 OR is_p0001-persk = 'S1' OR is_p0001-persk = 'S2'.

    ev_is_inactive = abap_true.
    ev_might_return = abap_true.

  ENDIF.

  " infotype checks - 2DO: customizbar machen
  IF ev_is_inactive IS INITIAL OR ev_might_return IS INITIAL.

    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr           = iv_pernr
        infty           = '2001'
        begda           = '18000101'
        endda           = '99991231'
      TABLES
        infty_tab       = lt_p2001
      EXCEPTIONS
        infty_not_found = 1
        OTHERS          = 2.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    " returning possible
    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0930'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_false.
      EXIT.
    ENDIF.

    " returning not possible
    READ TABLE lt_p2001 INTO ls_p2001
     WITH KEY subty = '0601'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_true.
      EXIT.
    ENDIF.

    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0300'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_true.
      EXIT.
    ENDIF.

    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0310'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_true.
      EXIT.
    ENDIF.

    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0612'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_true.
      EXIT.
    ENDIF.

    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0925'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_true.
      EXIT.
    ENDIF.

    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0935'.

    IF sy-subrc = 0.
      ev_is_inactive = abap_true.
      ev_might_return = abap_true.
      EXIT.
    ENDIF.

    READ TABLE lt_p2001 INTO ls_p2001
    WITH KEY subty = '0200'.

    IF sy-subrc = 0.
      IF sy-datum < ls_p2001-endda.
        ev_is_inactive = abap_true.
        ev_might_return = abap_true.
        EXIT.
      ENDIF.
    ENDIF.


  ENDIF.

ENDFUNCTION.
