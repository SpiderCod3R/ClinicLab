$(document).ready ->
  URL_BASE = window.location.origin + "/"
  texto_livre_id = 0
  ctl_id =0
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

  $('#destroy_free_text').click ->
    ctl_id     = $("#id_texto_livre").text()
    cliente_id = $("#cliente_id").val()
    bootbox.confirm
      message: 'Deseja mesmo excluir este Texto Livre?'
      buttons:
        confirm:
          label: 'Sim'
          className: 'btn-success'
        cancel:
          label: 'Ainda não'
          className: 'btn-danger'
      callback: (result) ->
        if result == true
          $.ajax
            type: 'get'
            url: URL_BASE + "clientes/#{cliente_id}/destroy_texto_livre"
            data:
              id: ctl_id
              cliente_id: cliente_id
            success: (response) ->
              cliente_id = cliente_id
              if agenda_id == ""
                window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/" + cliente_id + "/edit"
                window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/" + cliente_id + "/edit#texto_livre"
              else
                window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}"
              $('.nav-tabs a[href="#texto_livre"]').tab('show')


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

  $("#change_free_text").click ->
    $(this).hide()
    ctl_id = $("#id_texto_livre").text()
    $.ajax
      type: 'get'
      url: URL_BASE + 'search/cliente-texto-livre'
      data:
        id: ctl_id
        cliente_id: cliente_id
      success: (response) ->
        $("#free_text_area").hide()
        $('#cktext_area_editor').show()
        $("#include_new_free_text").fadeOut(500)
        $("#salvar_new_free_text").fadeIn(500)
        $("#next_page").fadeOut(500)
        $("#previous_page").fadeOut(500)
        $("#first_page").fadeOut(500)
        $("#last_page").fadeOut(500)
        $('#cancelar_free_text').show()
        CKEDITOR.instances['texto_livre_textarea'].setData(response.content_data)

  $('#salvar_new_free_text').click ->
    content=CKEDITOR.instances['texto_livre_textarea'].getData()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/include_texto_livre'
      dataType: 'JSON'
      data: 
        texto_livre:
          texto_livre_id: texto_livre_id
          cliente_id: cliente_id
          content: content
        cliente_texto_livre:
          id: ctl_id
      success: (response) ->
        if agenda_id == ""
          window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/" + cliente_id + "/edit"
          window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/" + cliente_id + "/edit#texto_livre"
        else
          window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}"
        
        
