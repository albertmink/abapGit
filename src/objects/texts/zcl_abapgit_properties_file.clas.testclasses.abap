class ltcl_properties_file definition final
  for testing
  duration short
  risk level harmless.

  private section.
    methods write_properties for testing raising cx_static_check.


endclass.

class zcl_abapgit_properties_file definition local friends ltcl_properties_file.

class ltcl_properties_file implementation.

  method write_properties.
    data lt_lxe_pairs_act type zif_abapgit_lxe_texts=>ty_text_pairs.

    lt_lxe_pairs_act = value #( ( textkey = 'header.description'
                                  s_text  = 'day'
                                  t_text  = 'dia' ) ).

    data(lo_cut) = new zcl_abapgit_properties_file( 'en' ).

    lo_cut->push_text_pairs( iv_objtype    = 'T1'
                             iv_objname    = 'OBJ1'
                             it_text_pairs = lt_lxe_pairs_act ).

    data(lv_act) = lo_cut->build_po_body( )->join_w_newline_and_flush( ).

    data(lo_buf) = new zcl_abapgit_string_buffer( ).
    lo_buf->add( 'header.description=dia' ).

    data(lv_exp) = lo_buf->join_w_newline_and_flush( ).


    cl_abap_unit_assert=>assert_equals( exp = lv_exp
                                        act = lv_act ).

  endmethod.

endclass.
