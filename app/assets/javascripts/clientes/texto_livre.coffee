$(document).ready ->
  URL_BASE = window.location.origin + "/"
  texto_livre_id = 0
  agenda_id  = $('#agenda_id').text()
  empresa_id = $('#empresa_id').text()
  cliente_id = $('#cliente_id').val()

  # $('.nav-tabs a[href="#texto_livre"]').tab('show')

  $("#cancelar_free_text").hide()
  $("#salvar_new_free_text").hide()

  $('#include_new_free_text').click ->
    $('#free_text_area').hide()
    $("#textoLivresModal.modal").modal()

  show_result_search = (resource) ->
    content = []
    x = 0
    while x < resource.length
      content.push("<div class='row'><div class='col-md-6 pull-left'>" +
                   resource[x].nome.toUpperCase() +
                   "</div>" +
                   "<div class='col-md-4 pull-right' id='include_free_text'>" +
                   "<a href='#' data-freetext-id='#{resource[x].id}' data-freetext='#{resource[x].content}' >"+
                   "Incluir</a>" + 
                   "</div></div>")
      x += 1
    content

  $(document).on "click", "#include_free_text", ->
    link = $(this).find("a")
    $('#cktext_area_editor').show()
    texto_livre_id = link.data().freetextId
    CKEDITOR.instances['texto_livre_textarea'].setData(link.data().freetext)
    BootstrapDialog.closeAll()
    $("#cancelar_free_text").show()
    $("#include_new_free_text").fadeOut(500)
    $("#salvar_new_free_text").fadeIn(500)
    $("#next_page").fadeOut(500)
    $("#previous_page").fadeOut(500)
    $("#first_page").fadeOut(500)
    $("#last_page").fadeOut(500)
    $("#change_free_text").fadeOut(500)
    $('#destroy_free_text').fadeOut(500)
    $('#print_free_text').fadeOut(500)

  $('#cancelar_free_text').click ->
    $("#include_new_free_text").fadeIn(500)
    $("#salvar_new_free_text").fadeOut(500)
    $('#cktext_area_editor').fadeOut(500)
    $("#free_text_area").fadeIn(500)
    $("#next_page").fadeIn(500)
    $("#previous_page").fadeIn(500)
    $("#first_page").fadeIn(500)
    $("#last_page").fadeIn(500)
    $("#change_free_text").fadeIn(500)
    $('#destroy_free_text').fadeIn(500)
    $(this).hide()

  $('#salvar_new_free_text').click ->
    content=CKEDITOR.instances['texto_livre_textarea'].getData()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/include_texto_livre'
      dataType: 'JSON'
      data: 
        cliente_texto_livre:
          id: $("#id_cliente_texto_livre").val()
          texto_livre_id: texto_livre_id
          cliente_id: $('#cliente_id').val()
          content_data: content
      success: (response) ->
        if agenda_id == ""
          window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/registros/" + $('#cliente_id').val() + "/edit"
          window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/registros/" + $('#cliente_id').val() + "/edit#texto_livre"
        else
          window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}"