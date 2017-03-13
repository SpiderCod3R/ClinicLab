$(document).ready ->
  localhost = window.location.origin + "/"
  agenda_id = $("#agenda_id").text()
  sala_espera_id = $("#sala_espera_id").text()
  empresa_id = $("#empresa_id").text()
  url_sala_espera = localhost + "empresa/#{empresa_id}/agendas/#{agenda_id}/sala_de_espera/#{sala_espera_id}/get_convenio"
  url_agenda = localhost + "empresa/#{empresa_id}/agendas/#{agenda_id}/get_convenio" 

  $("#return_to_agenda").click (event) ->
    event.preventDefault()
    if $("input[type='radio'][name='cliente_convenio_agenda']").is(':checked')
      if agenda_id != "" && sala_espera_id == ""
        send_data_through_ajax(url_agenda)
      if agenda_id != "" && sala_espera_id != ""
        send_data_through_ajax(url_sala_espera)
    else
      toastr.warning("Selecione um convênio", "ERRO de convênio", {timeOut: 5000})

  send_data_through_ajax=(url) ->
    $.ajax
      type: 'get'
      url: url
      dataType: 'json'
      data: 
        cliente_id: $("#cliente_id").val()
        cliente_convenio_id: $("input[name=cliente_convenio_agenda]:checked").val()
      success: (response) ->
        setTimeout (->
          toastr.info("Convênio adicionando", "Informação")
          setTimeout (->
            window.location.href = localhost + "empresa/" + empresa_id + "/agendas#sala_espera"
          ), 3000
        ), 3000