#= require utility/bootbox.min.js
$(document).ready ->
  localhost   = window.location.origin + "/"
  agenda_id  = $('#agenda_id').text()
  empresa_id = $('#empresa_id').text()
  cliente_id = $('#cliente_id').val()
  pdfs_params=[]
  upload = undefined

  $('#cliente_cliente_pdf_upload_pdf').change ->
    $("#pdf_selected").text("Arquivo selecionado - " + $('#cliente_cliente_pdf_upload_pdf').val().replace(/C:\\fakepath\\/i, ''))
    $("#pdf_selected").animate({ color: "#253095" }, 1000);


  $(document).on "click", "#btn_search_pdf", (event) ->
    event.preventDefault()
    $.ajax
      url: localhost + "empresa/#{empresa_id}/clientes/#{cliente_id}/search_pdf_remotely"
      type: 'GET'
      dataType: 'JSON'
      beforeSend: ->
        $('.loader').css({display:"block"})
      data:
        cliente:
          id: cliente_id
          empresa_id: empresa_id
        search:
          pdf:  $("#search_pdf_name").val()
          data: $("#search_pdf_data").val()
      success: (response) ->
        $("#search_pdf_name").val("")
        $("#search_pdf_data").val("")
        $('.loader').css({display:"none"})
        $('#cliente_pdf_uploads').empty()
        create_search_pdf_table(response)

  create_search_pdf_table = (response)->
    x = 0
    while x <= response.length
      if response[x] != undefined
        $('#cliente_pdf_uploads').append("<tr>" +
          "<td>" + response[x]["anotacoes"] + "</td>" +
          "<td class='center'>" + response[x]["data"] + "</td>" +
          "<td class='center'><a target='_blank' href='#{response[x]["url"]}'><i class='fa fa-cloud-download fa-2x'></a></td>" +
          "<td class='center'><center><i class='fa fa-trash fa-2x'></div></center></td></tr>")
      x = x + 1
