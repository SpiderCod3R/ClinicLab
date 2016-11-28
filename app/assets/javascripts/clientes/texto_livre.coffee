$(document).ready ->
  URL_BASE = window.location.origin + "/"
  texto_livre_id = 0

  $("#cancelar_free_text").hide()
  $("#change_free_text").hide()
  $("#salvar_new_free_text").hide()

  $('#include_new_free_text').click ->
    $('#free_text_area').hide()
    $.ajax
      type: 'get'
      url: URL_BASE + 'search/find-texto-livres'
      success: (response) ->
        result = show_result_search(response)
        # result_box = "<div class='row'><div class='col-md-6 pull-left'>"+
        #               "Textos Livres</div></div>" +
        #                 result
        if result != ""
          BootstrapDialog.show
            title: 'Textos Livres'
            message: result
            closable: false,
            draggable: true,
            buttons: [{
               label: 'Fechar',
               cssClass: 'btn-primary',
               autospin: false,
               action: (dialogRef) ->
                dialogRef.close()
                return false
            }]

  show_result_search = (resource) ->
    content = []
    x = 0
    while x < resource.length
      content.push("<div class='row'><div class='col-md-6 pull-left'>" +
                   resource[x].nome.toUpperCase() +
                   "</div>" +
                   "<div class='col-md-4 pull-right' id='include_free_text'>" +
                   "<a href='#' data-freetext='#{resource[x].content}' >"+
                   "Incluir</a>" + 
                   "</div></div>")
      x += 1
    content

  $(document).on "click", "#include_free_text", ->
    link = $(this).find("a")
    $('#cktext_area_editor').show()
    CKEDITOR.instances['texto_livre_textarea'].setData(link.data().freetext)
    BootstrapDialog.closeAll()
    $("#cancelar_free_text").show()
    $("#include_new_free_text").hide( "slide", { direction: "down"  }, 500 );
    $("#salvar_new_free_text").show( "slide", { direction: "up"  }, 500 );

  $('#cancelar_free_text').click ->
    $("#include_new_free_text").show( "slide", { direction: "up"  }, 500 );
    $("#salvar_new_free_text").hide( "slide", { direction: "down"  }, 500 );
    $('#cktext_area_editor').fadeOut(500)
    $(this).hide()

  $('#salvar_new_free_text').click ->
    content=CKEDITOR.instances['texto_livre_textarea'].getData()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/include_texto_livre'
      dataType: 'JSON'
      data: 
        texto_livre:
          id: texto_livre_id
          content: content
      success: (json) ->
        cliente_id = json