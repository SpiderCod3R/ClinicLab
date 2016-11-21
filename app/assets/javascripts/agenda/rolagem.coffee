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

  $(".link_menu_lateral").click ->
    offset = 12

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

  # Carregamento quando o scroll for igual a 0
  $(window).scroll ->
    tbody = $('.table-agenda').find('tbody').attr("id")
    data  = $("#q_data_cont_3i :selected").val() + "/" + $("#q_data_cont_2i :selected").val() + "/" + $("#q_data_cont_1i :selected").val()
    if $(window).scrollTop() + $(window).height() >= $(document).height()
      loadler.fadeIn 'fast'
      loadData("acao=#{tbody}&offset=#{offset}&page_limit=12&data=#{data}")
      offset += 12
