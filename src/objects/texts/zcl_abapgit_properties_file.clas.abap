class zcl_abapgit_properties_file definition
  public
  final
  create public .

  public section.
    interfaces zif_abapgit_i18n_file.

    methods constructor
      importing iv_lang type laiso.

    methods push_text_pairs
      importing iv_objtype    type trobjtype
                iv_objname    type lxeobjname
                it_text_pairs type zif_abapgit_lxe_texts=>ty_text_pairs
      raising   zcx_abapgit_exception.

  protected section.
  private section.


    data mv_lang type laiso.
    data mt_pairs type zif_abapgit_lxe_texts=>ty_text_pairs.

    methods build_po_body
      returning value(ro_buf) type ref to zcl_abapgit_string_buffer.

endclass.



class zcl_abapgit_properties_file implementation.


  method build_po_body.

*    FIELD-SYMBOLS <ls_pair> LIKE LINE OF mt_pairs.
*    FIELD-SYMBOLS <ls_comment> LIKE LINE OF <ls_pair>-comments.
*
    create object ro_buf.
*
*    LOOP AT mt_pairs ASSIGNING <ls_pair>.
*      IF sy-tabix <> 1.
*        ro_buf->add( '' ).
*      ENDIF.
*
*      " TODO integrate translator comments ?
*
**      SORT <ls_pair>-comments BY kind.
**      LOOP AT <ls_pair>-comments ASSIGNING <ls_comment>.
**        ro_buf->add( |#{ get_comment_marker( <ls_comment>-kind ) } { <ls_comment>-text }| ).
**      ENDLOOP.
*
**      ro_buf->add( |msgid { quote( <ls_pair>-source ) }| ).
*      ro_buf->add( |msgstr { quote( <ls_pair>-target ) }| ).
*    ENDLOOP.
    loop at mt_pairs into data(pair).
      data(str) = |{ pair-textkey }={ pair-t_text }|.
      ro_buf->add( str ).
    endloop.
  endmethod.



  method constructor.
    mv_lang = to_lower( iv_lang ).
  endmethod.



  method push_text_pairs.

    loop at it_text_pairs into data(text_pair).
      append text_pair to mt_pairs.
    endloop.


*
*    DATA ls_out LIKE LINE OF mt_pairs.
*    FIELD-SYMBOLS <ls_in> LIKE LINE OF it_text_pairs.
*    FIELD-SYMBOLS <ls_out> LIKE LINE OF mt_pairs.
*    DATA ls_comment LIKE LINE OF <ls_out>-comments.
*
*    LOOP AT it_text_pairs ASSIGNING <ls_in>.
*      CHECK <ls_in>-s_text IS NOT INITIAL.
*
*      READ TABLE mt_pairs ASSIGNING <ls_out> WITH KEY source = <ls_in>-s_text.
*      IF sy-subrc <> 0.
*        ls_out-source = <ls_in>-s_text.
*        INSERT ls_out INTO TABLE mt_pairs ASSIGNING <ls_out>.
*        ASSERT sy-subrc = 0.
*      ENDIF.
*
*      IF <ls_out>-target IS INITIAL. " For a case of orig text duplication
*        <ls_out>-target = <ls_in>-t_text.
*      ENDIF.
*
*      ls_comment-kind = c_comment-reference.
*      ls_comment-text = condense( |{ iv_objtype }/{ iv_objname }/{ <ls_in>-textkey }| )
*        && |, maxlen={ <ls_in>-unitmlt }|.
*      APPEND ls_comment TO <ls_out>-comments.
*      ASSERT sy-subrc = 0.
*    ENDLOOP.

  endmethod.




  method zif_abapgit_i18n_file~ext.
  endmethod.


  method zif_abapgit_i18n_file~lang.
  endmethod.


  method zif_abapgit_i18n_file~render.
  endmethod.


  method zif_abapgit_i18n_file~translate.
  endmethod.
endclass.
