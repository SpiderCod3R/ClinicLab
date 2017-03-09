$(document).ready ->
  localhost = window.location.origin + "/"
  agenda_id = $("#agenda_id").text()
  sala_espera_id = $("#sala_espera_id").text()
  empresa_id = $("#empresa_id").text()
  # cliente_convenios_count = $("#cliente_convenios_count").text()

  $("#return_to_agenda").click (event) ->
    event.preventDefault()
    if $("input[type='radio'][name='cliente_convenio_agenda']").is(':checked')
      $.ajax
        type: 'get'
        url: localhost + "empresa/#{empresa_id}/agendas/#{agenda_id}/sala_de_espera/#{sala_espera_id}/get_convenio"
        dataType: 'json'
        data: 
          cliente_id: $("#cliente_id").val()
          cliente_convenio_id: $("input[name=cliente_convenio_agenda]:checked").val()
        success: (response) ->
          window.location.href = localhost + "empresa/" + empresa_id + "/agendas#sala_espera"
    else
      toastr.warning("Selecione um convênio", "ERRO de convênio", {timeOut: 5000})
