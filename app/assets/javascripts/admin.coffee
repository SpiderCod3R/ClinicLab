# -*- JQUERY -*-
#= require JQUERY/jquery.min
#= require jquery-ui/effect.all
#= require jquery-ui/effect-blind
#= require JQUERY/jquery-migrate-1.2.1.min
#= require JQUERY/jquery.maskMoney
#= require JQUERY/jquery.numeric.pack
#= require JQUERY/jquery.maskedinput-1.1.4.pack
#= require jquery_ujs


# -*- BOOTSTRAP -*-
#= require BOOTSTRAP/bootstrap
#= require BOOTSTRAP/bootstrap-dialog
#= require BOOTSTRAP/bootstrap-select
#= require BOOTSTRAP/bootstrap-datepicker
#= require BOOTSTRAP/bootstrap-waitingfor

# -*- REQUIRES DO GCLINIC -*-

#= require check_all
#= require delete
#= require SB-ADMIN/metisMenu/dist/metisMenu.min
# require SB-ADMIN/morrisjs/morris.min
# require morris-data
# require flot-data
#= require SB-ADMIN/sb-admin-2
#= require SB-ADMIN/material_toast/materialize
#= require SB-ADMIN/material_toast/initial
#= require SB-ADMIN/material_toast/toasts


$("button#permissao_formclose").click ->
  $("#painel_permissao_nome").val('');
  $("#painel_permissao_model_class").val('');
  $("#permissao_error_messages").empty();
  $("#new_permissao_modal_form").modal('toogle')