$(document).ready ->
  URL_BASE = window.location.origin + "/"

  $('#incluir_historico').click ->
    $('#old_historico').empty()
    $('div#new_historico').show()
    return
  $('#editar_historico').click ->
    $('#old_historico').empty()
    $('div#new_historico').show()
    historico_id = $(this).data().historicoId
    if historico_id != ''
      $.ajax
        type: 'POST'
        url: URL_BASE + 'clientes/retorna_historico'
        dataType: 'JSON'
        data: historico_id: historico_id
        success: (json) ->
          historico = json
          tinyMCE.activeEditor.setContent('<p>' + historico.data + '</p><p>' + historico.usuario + '</p><p>' + historico.idade + '</p><br/><p>' + historico.indice + '</p>')
          tinyMCE.DOM.setStyle(tinyMCE.DOM.get("elm1" + '_ifr'), 'height', '200px')
          return
    return
  return