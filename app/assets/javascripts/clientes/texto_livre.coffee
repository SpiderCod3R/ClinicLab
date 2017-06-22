$(document).ready ->
  URL_BASE = window.location.origin + "/"
  texto_livre_id = 0
  cliente_texto_livre_id=0
  agenda_id  = $('#agenda_id').text()
  empresa_id = $('#empresa_id').text()
  cliente_id = $('#cliente_id').val()

  $("#cancelar_free_text").hide()
  $("#salvar_new_free_text").hide()

  #=> Abre campos para adicionar o texto livre
  $(document).on "click", "#include_new_free_text", (event) ->
    event.preventDefault()
    $(this).hide()
    $("#free_text_area").hide()
    $('#change_free_text').hide()
    $('#destroy_free_text').hide()
    $('#manual_pagination').hide()
    $('#print_free_text').hide()
    $("#cancelar_free_text").show()
    $("#salvar_new_free_text").show()
    $('#cktext_area_editor').show()

  #=> Pega o Texto Livre selecionado e adiciona no Editor de Texto
  $(document).on "click", "#add_freeText", (event) ->
    event.preventDefault()
    CKEDITOR.instances['texto_livre_textarea'].setData()
    if $("#cliente_texto_livres :selected").val() == ""
      bootbox.alert("<h4>Você deve selecionar um Texto Livre</h4>")
    else
      $.ajax
        type: 'get'
        url: URL_BASE + 'search/texto_livre'
        data:
          id: $("#cliente_texto_livres :selected").val()
        success: (response) ->
          texto_livre_id = response.content.id
          CKEDITOR.instances['texto_livre_textarea'].insertHtml(response.content.content)

  #=> Exclui o Texto Livre
  $('#destroy_free_text').click ->
    cliente_id= $("#cliente_id").val()
    cliente_texto_livre_id= $("#id_cliente_texto_livre").text()
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

  #=> Cancela inclusao ou alteração do Texto livre
  $(document).on "click", "#cancelar_free_text", (event) ->
    event.preventDefault()
    $(this).hide()
    $("#include_new_free_text").fadeIn(500)
    $('#manual_pagination').fadeIn(500)
    $("#salvar_new_free_text").fadeOut(500)
    $('#cktext_area_editor').fadeOut(500)
    $("#free_text_area").fadeIn(500)
    $("#next_page").fadeIn(500)
    $("#previous_page").fadeIn(500)
    $("#first_page").fadeIn(500)
    $("#last_page").fadeIn(500)
    $("#change_free_text").fadeIn(500)
    $('#destroy_free_text').fadeIn(500)
    CKEDITOR.instances['texto_livre_textarea'].setData()

  #=> Colecta o Texto Livre sendo exibido e retorna para o editor de texto_livre
  # Com a opção de selecionar outro texto livre no lugar do mesmo
  $(document).on "click", "#change_free_text", (event) ->
    event.preventDefault()
    $(this).hide()
    cliente_texto_livre_id = $("#id_cliente_texto_livre").text()
    $('#destroy_free_text').hide()
    $('#print_free_text').hide()
    $.ajax
      type: 'get'
      url: URL_BASE + 'search/cliente-texto-livre'
      data:
        id: cliente_texto_livre_id
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

  #= Colecta o Texto Livre do Editor de Texto e Envia para o Controller
  # Support::ClienteSupportController no metodo include_texto_livre
  $(document).on "click", "#salvar_new_free_text", (event) ->
    event.preventDefault()
    content=CKEDITOR.instances['texto_livre_textarea'].getData()
    if content == ""
      bootbox.alert
        message: "Texto Livre não pôde ser salvo \n Preencha algo no editor de texto"
        backdrop: true
    else
      $.ajax
        type: 'POST'
        url: URL_BASE + 'clientes/include_texto_livre'
        dataType: 'JSON'
        data:
          cliente_texto_livre:
            id: cliente_texto_livre_id
            cliente_id: cliente_id
            content: content
            texto_livre_id: texto_livre_id
        success: (response) ->
          if agenda_id == ""
            window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/" + cliente_id + "/edit"
            window.location.href = URL_BASE + "empresa/" + empresa_id + "/clientes/" + cliente_id + "/edit#texto_livre"
          else
            window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}"
