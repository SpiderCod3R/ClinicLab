#= require utility/bootbox.min.js
$(document).ready ->
  URL_BASE = window.location.origin + "/"
  empresa_id = $('#empresa_id').text()
  cliente_id = $('#cliente_id').val()

  $(document).on "click", "#btn_salvar_sadt", (event) ->
    event.preventDefault()
    error_messages = []
    if $('#cliente_sadt_indicacao_clinica').val() == ""
      error_messages.push('<li>Indicação Clínica deve ser preenchida</li>')
    if $('#cliente_sadt_sadt_grupo_grupo_id option:selected').val() == ""
      error_messages.push('<li>Grupo deve ser selecionado</li>')
    if error_messages.length != 0
      return BootstrapDialog.show
        type: BootstrapDialog.TYPE_DANGER
        title: 'Erros Encontrados: Para prosseguir resolva os seguintes problemas'
        message: error_messages
        closable: false
        buttons: [ {
          label: 'Fechar'
          action: (dialogRef) ->
            dialogRef.close()
            error_messages = []
            false
        } ]
    else
      $('form.edit_cliente').unbind('submit').submit()
    return

  $(document).on "click", "#btn_search_sadt", (event) ->
    event.preventDefault()
    $.ajax
      url: URL_BASE + "empresa/#{empresa_id}/clientes/#{cliente_id}/search_sadt_remotely"
      type: 'GET'
      dataType: 'JSON'
      beforeSend: ->
        $('.loader').css({display:"block"})
      data:
        cliente:
          id: cliente_id
          empresa_id: empresa_id
        search:
          indicacao_clinica:  $("#search_sadt_indicacao_clinica").val()
          data: $("#search_sadt_data").val()
      success: (json) ->
        $("#search_sadt_indicacao_clinica").val("")
        $("#search_sadt_data").val("")
        $('.loader').css({display:"none"})
        $('#cliente_sadts').empty()
        create_search_sadt_table(json)

  create_search_sadt_table = (cluster)->
    x = 0
    while x <= cluster.length
      if cluster[x] != undefined
        $('#cliente_sadts').append("<tr>" +
          "<td class='indicacao_clinica'>" + cluster[x]["indicacao_clinica"] + "</td>" +
          "<td>" + formata_data(cluster[x]["data"]) + "</td>" +
          "<td class='center'><a target='_blank' href='/empresa/#{empresa_id}/clientes/#{cliente_id}/print_sadt.pdf?locale=pt-BR&sadt_id=#{cluster[x]['id']}'><i class='fa fa-print fa-2x'></a></td>" +
          # "<td class='center'><center><i class='fa fa-trash fa-2x'></div></center></td>"
          "</tr>")
      x = x + 1

  formata_data = (data) ->
    ano = undefined
    d = undefined
    data_informada = undefined
    dia = undefined
    mes = undefined
    pad = undefined
    pad = (c) ->
      if c < 10
        '0' + c
      else
        c
    if data == null
      return ''
    else
      data_informada = data.split('-')
      ano = data_informada[0]
      mes = data_informada[1]
      mes--
      dia = data_informada[2]
      d = new Date(ano, mes, dia)
      [
        pad(d.getDate())
        pad(d.getMonth() + 1)
        d.getFullYear()
      ].join '/'

  return