#= require bootbox.min.js
$(document).ready ->
  localhost   = window.location.origin + "/"
  agenda_id  = $('#agenda_id').text()
  empresa_id = $('#empresa_id').text()
  cliente_id = $('#cliente_id').val()
  pdfs_params=[]
  upload = undefined

  #=> METODO PARA COLETAR A DATA DO DIA
  date_collector =->
    data=""
    d = new Date
    dia = d.getDate()
    mes = d.getUTCMonth()
    mes++
    ano = d.getFullYear()
    if dia<10
      dia='0'+dia
    if mes<10
      mes='0'+mes
    data = dia + '/' + mes + '/' + ano
    return data

  $("#save_new_pdf").hide()
  $("#calcel_pdf_upload").hide()

  # Libera campos para envio de PDF's
  $('#include_new_pdf').click (event),->
    event.preventDefault()
    $('#updload_pdf_area').show()
    $("#save_new_pdf").show()
    $("#calcel_pdf_upload").show()
    $(this).hide()

  # Limpa campos e cancela envio de PDF's
  $('#calcel_pdf_upload').click (event),->
    event.preventDefault()
    $(this).hide()
    $("#save_new_pdf").hide()
    $('#updload_pdf_area').hide()
    $('#include_new_pdf').show()
    $("#cliente_cliente_pdf_upload_anotacoes").val("")
    $("#cliente_cliente_pdf_upload_pdf").val("")

  # => METODO PARA MONTAR A TABELA DOS PDF
  create_preview_pdf_table = (anotacoes, data)->
    $('#table_pdf').append("<tr>" +
      "<td class='center'><img src='/assets/load.gif', height= '20', width= '20'></td>" +
      "<td>" + anotacoes + "</td>" +
      "<td>" + data + "</td>" +
      "<td></td>" +
      "<td><center><div id='icon-trash'></div></center></td></tr>")

  $('#cliente_cliente_pdf_upload_pdf').on 'change', (event) ->
    files = event.target.files
    upload = files[0]
    console.log upload
    return

  $('#add_pdf_upload').click (event),->
    event.preventDefault()
    anotacoes = $("#cliente_cliente_pdf_upload_anotacoes").val()
    data = date_collector()
    pdfs_params.push
      'anotacoes' : anotacoes
      'pdf' : upload
    create_preview_pdf_table(anotacoes, data)
    $("#cliente_cliente_pdf_upload_anotacoes").val("")
    $("#cliente_cliente_pdf_upload_pdf").val("")

  $('#save_new_pdf').click (event), ->
    event.preventDefault()
    alert("HAHA")
    # $.ajax
    #   url: localhost + "empresa/#{empresa_id}/clientes/#{cliente_id}/save_pdfs_remotely"
    #   type: 'PUT'
    #   dataType: 'JSON'
    #   beforeSend: ->
    #     toastr.warning("Por-favor não saia dessa tela.", "Aguarde!")
    #   data:
    #     cliente:
    #       id: cliente_id
    #       empresa_id: empresa_id
    #       cliente_pdf_upload: pdfs_params
