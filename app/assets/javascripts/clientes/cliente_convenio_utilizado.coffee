#= require JQUERY/jquery.min
jQuery ->
  $(".cliente_convenio_agenda").on 'click', (event) ->
    cliente_id=$("#cliente_id").val()
    $.ajax
      type: 'get'
      url: window.location.origin + "/empresa/#{empresa_id}/clientes/#{cliente_id}/change_convenio"
      dataType: 'json'
      data:
        cliente_id: cliente_id
        cliente_convenio_id: $(this).val()
      success: (response) ->
        setTimeout (->
          toastr.info("Convênio atualmente utilizado alterado", "Informação")
        ), 3000
