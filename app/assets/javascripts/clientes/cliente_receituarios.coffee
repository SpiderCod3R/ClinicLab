#= require bootbox.min.js
$(document).ready ->
  URL_BASE = window.location.origin + "/"
  receituario = []
  i=0

  $("#cancel_recipe").hide()
  $("#save_new_recipe").hide()

  $('#include_new_recipe').click ->
    $('#include_new_recipe').hide()
    $("#change_recipe").hide()
    $("#destroy_recipe").hide()
    $("#recipes_container").hide()
    $("#save_new_recipe").show()
    $('#include_recipe_container').show()
    $('#cancel_recipe').show()
    $('#recipe_manual_pagination').hide()


  $('#cancel_recipe').click ->
    $('#include_new_recipe').show()
    $("#save_new_recipe").hide()
    $("#change_recipe").show()
    $("#destroy_recipe").show()
    $("#recipes_container").show()
    $('#recipe_manual_pagination').show()
    $('#include_recipe_container').hide()
    $('#cancel_recipe').hide()
    CKEDITOR.instances['receituario_content_textarea'].setData()

  $("#save_new_recipe").click ->
    content=CKEDITOR.instances['receituario_content_textarea'].getData()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/include_recipe'
      dataType: 'JSON'
      data:
        cliente:
          id: $("#cliente_id").val()
          cliente_recipe:
            content: content
      success: (response) ->
        window.location.href = URL_BASE + "clientes/" + $("#cliente_id").val() + "/edit"
        window.location.href = URL_BASE + "clientes/" + $("#cliente_id").val() + "/edit#receituario"

  $('#add_recipe').click ->
    if $("#cliente_receituario :selected").val() == ""
      bootbox.alert("<h4>Você deve selecionar uma receita</h4>")
    else
      $.ajax
        type: 'get'
        url: URL_BASE + 'search/receituario'
        data:
          id: $("#cliente_receituario :selected").val()
        success: (response) ->
          CKEDITOR.instances['receituario_content_textarea'].insertHtml(response.content.recipe)
