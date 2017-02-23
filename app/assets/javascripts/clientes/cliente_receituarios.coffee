#= require bootbox.min.js
$(document).ready ->
  URL_BASE = window.location.origin + "/"
  environment_name = $('#cliente_empresa_name').val()

  $("#cancel_recipe").hide()
  $("#save_new_recipe").hide()

  # => Exibe o form para add receita
  $('#include_new_recipe').click ->
    $('#include_new_recipe').hide()
    $("#change_recipe").hide()
    $("#destroy_recipe").hide()
    $("#recipes_container").hide()
    $("#save_new_recipe").show()
    $('#include_recipe_container').show()
    $('#cancel_recipe').show()
    $('#recipe_manual_pagination').hide()
    $("#id_receituario").empty()

  # => Cancelar inclusão da receita
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

  # => Salvar ou Alterar
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
            id: $("#id_receituario").text()
            content: content
      success: (response) ->
        window.location.href = URL_BASE + "empresa/" + environment_name + "/clientes/" + $("#cliente_id").val() + "/edit"
        window.location.href = URL_BASE + "empresa/" + environment_name + "/clientes/" + $("#cliente_id").val() + "/edit#receituario"

  # => Incluir nova receita
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

  # => Alterar Receita
  $("#change_recipe").click ->
    $(this).hide()
    $.ajax
      type: 'get'
      url: URL_BASE + 'search/cliente_receituario'
      data:
        id: $("#id_receituario").text()
        cliente_id: $("#cliente_id").val()
      success: (response) ->
        $('#cancel_recipe').show()
        $('#include_recipe_container').show()
        $("#include_new_recipe").hide()
        $("#save_new_recipe").fadeIn(500)
        $("#recipe_manual_pagination").hide()
        $("#destroy_recipe").hide()
        $("#recipes_container").hide()
        CKEDITOR.instances['receituario_content_textarea'].setData(response.content.recipe)

  $('#destroy_recipe').click ->
    cliente_id = $("#cliente_id").val()
    recipe_id = $("#id_receituario").text()
    bootbox.confirm
      message: 'Deseja mesmo excluir esta Receita?'
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
            url: URL_BASE + "/clientes/#{cliente_id}/receita/#{recipe_id}/remove"
            data:
              recipe_id: recipe_id
              cliente_id: cliente_id
            success: (response) ->
              cliente_id = $("#cliente_id").val()
              window.location.href=URL_BASE + "empresa/" + environment_name + "/clientes/" + cliente_id + "/edit"
              window.location.href=URL_BASE + "empresa/" + environment_name + "/clientes/" + cliente_id + "/edit#receituario"
              $('.nav-tabs a[href="#texto_livre"]').tab('show')