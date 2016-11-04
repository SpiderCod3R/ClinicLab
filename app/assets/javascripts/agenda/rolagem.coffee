#= require JQUERY/jquery.min

$(document).ready ->
  empresa_id = $("#agenda_empresa_id").val()
  localhost = window.location.origin
  urlPost= localhost + "/painel/empresas/#{empresa_id}/agendas/load_more_data"
  offset = 2

  # window.onkeydown = (e) ->
  #   if e.keyCode == 116
  #     e.keyCode = 0
  #     e.returnValue = false
  #     return false
  #   return

  $.ajaxSetup
    url: urlPost
    type: 'POST'
    beforeSend: ''
    error: ''

  loadler = $(".lendodados")
  listler = $("#agenda_content")

  # listler.empty()

  loadData = (instructions) ->
    $.ajax
      data: instructions
      beforeSend: ''
      error: ''
      success: (read) ->
        if read != '3'
          #Se read for diferente de 3 faz o carregamento
          listler.append read
          #insere novo conteudo depois do conteudo já exibido
          loadler.delay(300).fadeOut 'slow'
          #Inibe o load de carregamento
        else
          #Se a read for igual a 3 é porque não existe mais resultado
          $(loadler).css 'cursor', 'pointer'
          loadler.text('Não existem mais dados. Recarregar página').click ->
            location.reload()
            return
          #loadler.delay(300).fadeOut("slow");
  # Trocando o ID
  # $('.table-agenda').find('tbody').attr("id","newId");
  # loadData("action=#{tbody}&offset=0&page_limit=12")
  #Carregamento quando o scroll for igual a 0
  $(window).scroll ->
    tbody = $('.table-agenda').find('tbody').attr("id")
    if $(window).scrollTop() + $(window).height() >= $(document).height()
      loadler.fadeIn 'fast'
      # loadData 'acao=ler&offset=' + offset + '&limit=2'
      loadData("acao=#{tbody}&offset=0&page_limit=2")
      offset += 2
    return