$("button#permissao_formclose").click ->
  $("#painel_permissao_nome").val('');
  $("#painel_permissao_model_class").val('');
  $("#permissao_error_messages").empty();
  $("#new_permissao_modal_form").modal('toogle')

$(".multi-select").chosen
  no_results_text: 'Nenhuma permissao encontrada'
  width: '570px'