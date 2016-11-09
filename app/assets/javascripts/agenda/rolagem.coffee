#= require JQUERY/jquery.min

$(document).ready ->
  empresa_id = $("#agenda_empresa_id").val()
  localhost = window.location.origin
  urlPost= localhost + "/painel/empresas/#{empresa_id}/agendas/load_more_data"
  offset = 12

  # travar o F5 nesta pagina
  window.onkeydown = (e) ->
    if e.keyCode == 116
      e.keyCode = 0
      e.returnValue = false
      return false
    return

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
        #loadler.delay(300).fadeOut("slow");
  # Trocando o ID
  # $('.table-agenda').find('tbody').attr("id","newId");
  tbody   = $('.table-agenda').find('tbody').attr("id")
  loadData("acao=#{tbody}&offset=0&page_limit=12")

  # Carregamento quando o scroll for igual a 0
  $(window).scroll ->
    tbody = $('.table-agenda').find('tbody').attr("id")
    if $(window).scrollTop() + $(window).height() >= $(document).height()
      loadler.fadeIn 'fast'
      loadData("acao=#{tbody}&offset=#{offset}&page_limit=2")
      offset += 2
