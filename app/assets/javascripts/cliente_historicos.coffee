$(document).ready ->
  URL_BASE = window.location.origin + "/"
  error_messages = []
  historico_id = 0

  $('#incluir_historico').click ->
    $('div#old_historico').hide()
    $('div#new_historico').show()
    return
  $('#editar_historico').click ->
    $('div#old_historico').hide()
    $('div#new_historico').show()
    $('div#show_historico').show()
    historico_id = $(this).data().historicoId
    if historico_id != 0
      $.ajax
        type: 'POST'
        url: URL_BASE + 'clientes/retorna_historico'
        dataType: 'JSON'
        data: historico_id: historico_id
        success: (json) ->
          $('#show_historico').empty()
          historico = json
          $('#show_historico').append('<p>' + historico.data + '</p><p>' + historico.usuario + '</p><p>' + historico.idade + '</p>')
          tinyMCE.activeEditor.setContent(historico.indice)
          return
    return
  $('#salvar_historico').click ->
    i = 0
    idade = undefined
    indice = undefined
    type = undefined
    indice = tinyMCE.activeEditor.getContent()
    indice = indice.replace(/<[^>]*>/ig, ' ').replace(/<\/[^>]*>/ig, ' ').replace(/&nbsp;|&#160;/gi, ' ').replace(/\s+/ig, ' ').trim()
    if historico_id != 0
      $.ajax
        type: 'POST'
        url: URL_BASE + 'clientes/atualiza_historico'
        dataType: 'JSON'
        data: historico:
          id: historico_id
          indice: indice
        success: (json) ->
          cliente_id = json
          window.location.href = URL_BASE + "clientes/" + cliente_id + "/edit"
          window.location.href = URL_BASE + "clientes/" + cliente_id + "/edit#historico"
          return
      return
    else
      idade = $('#cliente_idade').val()
      if idade == ''
        error_messages.push '<li>A data de nascimento deve ser preenchida</li>'
        $('#cliente_nascimento').focus()
        return false
      if error_messages.length != 0
        type = BootstrapDialog.TYPE_DANGER
        return BootstrapDialog.show
          type: type
          title: 'Erros Encontrados: Para prosseguir preencha os campos abaixo.'
          message: error_messages
          closable: false
          buttons: [ {
            label: 'Fechar'
            action: (dialogRef) ->
              dialogRef.close()
              false
          } ]
      else
        $.ajax
          type: 'POST'
          url: URL_BASE + 'clientes/salva_historico'
          dataType: 'JSON'
          data: historico:
            idade: idade
            indice: indice
          success: (json) ->
            cliente_id = json
            window.location.href = URL_BASE + "clientes/" + cliente_id + "/edit"
            return
        return
    return
  return