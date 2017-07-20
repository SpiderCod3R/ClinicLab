$(document).ready ->
  URL_BASE = window.location.origin + '/'
  cliente_convenio_id = 0
  agenda_id = $("#agenda_id").text()
  sala_espera_id = $("#sala_espera_id").text()
  empresa_id = $("#empresa_id").text()
  cliente_id = $("#cliente_id").val()
  editando = false
  cliente_convenio_utilizando_agora= undefined

  $(document).on 'change', '#cliente_convenio_utilizando_agora', (event) ->
    cliente_convenio_utilizando_agora = this.checked

  $(document).on 'click', '#adicionar_convenio_em_cliente', (event) ->
    event.preventDefault()
    error_messages = []
    if $('#cliente_convenio_convenio_id option:selected').val() == undefined
      error_messages.push('<li>Convênio deve ser selecionado</li>')
    if error_messages.length != 0
      return BootstrapDialog.show
        type: BootstrapDialog.TYPE_DANGER
        title: 'Erros Encontrados: Para prosseguir resolva os seguintes problemas'
        message: error_messages
        closable: false
        buttons: [ {
          label: 'Fechar'
          action: (dialogRef) ->
            dialogRef.close()
            error_messages = []
            false
        } ]
    else
      adiciona_linha_tabela_convenios()
      limpa_campos_cliente_convenios()


  convenio_selecionado = (value) ->
    if value==true
      symbol = "<td>" +
                "<center>" +
                  "<i class='fa fa-check-circle fa-2x'></i>" +
                "</center>" +
              "</td>"
    else
      symbol = "<td>" +
                "<center>" +
                  "<i class='fa fa-times-circle fa-2x'></i>" +
                "</center>" +
              "</td>"
    return symbol

  adiciona_linha_tabela_convenios = ->
    # pegando valores dos campos
    id_convenio = $('#cliente_convenio_convenio_id option:selected').val()
    nome_convenio = $('#cliente_convenio_convenio_id option:selected').text()
    cliente_convenio_id = $("#cliente_convenio_id").val()

    utilizando_agora = convenio_selecionado(cliente_convenio_utilizando_agora)

    # montando a tabela
    $('#tabela_cliente_convenios').append "<tr>" +
                                            "<td>#{nome_convenio}</td>" +
                                            "<td>" +
                                              "<center>" +
                                                "<i class='fa fa-exclamation-circle fa-2x'></i>" +
                                              "</center>" +
                                            "</td>" +
                                            "#{utilizando_agora}" +
                                            "<td>" +
                                              "<a href='#{id_convenio}' class=excluir_convenio>" +
                                                "<center>" +
                                                  "<i class='fa fa-trash fa-2x' aria-hidden='true'></i>" +
                                                "</center>" +
                                              "</a>" +
                                            "</td>" +
                                          "</tr>"
    # armazenando os valores em um array
    _cliente_convenios_.push
      'cliente_convenio_id': cliente_convenio_id
      'convenio_id': id_convenio
      'convenio_nome': nome_convenio
      'matricula': $('#cliente_convenio_matricula').val()
      'validade_carteira': $('#cliente_convenio_validade_carteira').val()
      'produto': $('#cliente_convenio_produto').val()
      'titular': $('#cliente_convenio_titular').val()
      'plano': $('#cliente_convenio_plano').val()
      'utilizando_agora': false

  limpa_campos_cliente_convenios = ->
    $('#cliente_convenio_convenio_id').val('').trigger('change')
    $('#cliente_convenio_status_convenio_true:checked').prop('checked', false)
    $('#cliente_convenio_status_convenio_false:checked').prop('checked', false)
    $('#cliente_convenio_matricula').val('')
    $('#cliente_convenio_validade_carteira').val('')
    $('#cliente_convenio_produto').val('')
    $('#cliente_convenio_titular').val('')
    $('#cliente_convenio_plano').val('')
    return

  $(document).on 'click', '.excluir_convenio', (event) ->
    event.preventDefault()
    i = 0
    while i < _cliente_convenios_.length
      if parseInt($(this).attr('href')) == parseInt(_cliente_convenios_[i]['convenio_id'])
        _cliente_convenios_.splice i, 1
        $(this).closest('tr').fadeOut()
      i = i + 1
    false

  $('form.edit_cliente').submit (event) ->
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/cria_session_cliente_convenios'
      dataType: 'JSON'
      data:
        convenios_attributes: _cliente_convenios_
        option: _option_
      success: () ->
        $('form.edit_cliente').unbind('submit').submit()
        return
    return

  $('form.new_cliente').submit (event) ->
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/cria_session_cliente_convenios'
      dataType: 'JSON'
      data:
        convenios_attributes: _cliente_convenios_
        option: _option_
      success: () ->
        $('form.new_cliente').unbind('submit').submit()
        return
    return

  $(document).on 'click', '#change_convenio_cliente', (event) ->
    event.preventDefault()
    resource = $(this)

    $("#cliente_convenio_id").val(resource.data().id)
    $("#cliente_convenio_convenio_id option[value='#{resource.data().convenioId}']").prop('selected', true)
    $("#cliente_convenio_matricula").val(resource.data().convenioMatricula)
    $("#cliente_convenio_validade_carteira").val(resource.data().convenioValidade)
    $("#cliente_convenio_produto").val(resource.data().convenioProduto)
    $("#cliente_convenio_titular").val(resource.data().convenioTitular)
    $("#cliente_convenio_plano").val(resource.data().convenioPlano)
    # $("#adicionar_convenio_em_cliente").fadeOut(500)
    # $("#alterar_convenio_em_cliente").fadeIn(500)
    resource.closest('tr').find('td').hide()
    _option_="edit"

  $(document).on 'click', '#alterar_convenio_em_cliente', (event) ->
    event.preventDefault()
    $.ajax
      type: 'PUT'
      url: URL_BASE + "empresa/#{empresa_id}/clientes/#{cliente_id}/atualizar_convenio"
      dataType: 'JSON'
      data:
        cliente_id: $('#cliente_id').val()
        cliente_convenio_id: $("#cliente_convenio_id").val()
        cliente_convenio_convenio_id: $("#cliente_convenio_convenio_id").val()
        cliente_convenio_validade_carteira: $("#cliente_convenio_validade_carteira").val()
        cliente_convenio_produto: $("#cliente_convenio_produto").val()
        cliente_convenio_titular: $("#cliente_convenio_titular").val()
        cliente_convenio_titular: $("#cliente_convenio_titular").val()
        cliente_convenio_plano: $("#cliente_convenio_plano").val()
      success: (response) ->
        $('form.edit_cliente').unbind('submit').submit()

  # metodo que exclui o convenio já salvo no bd
  $(document).on 'click', '.delete_cliente_convenio', (event) ->
    event.preventDefault()
    index = undefined
    link = undefined
    link = $(this)
    # chama caixa de confirmacao
    BootstrapDialog.confirm
      title: 'AVISO!'
      message: 'TEM CERTEZA?'
      type: BootstrapDialog.TYPE_PRIMARY
      closable: false
      draggable: true
      btnCancelLabel: 'Cancelar'
      btnOKLabel: 'Excluir'
      btnOKClass: 'btn-primary'
      callback: (result) ->
        if result
          # passa os dados para o controller
          $.ajax
            type: 'GET'
            url: URL_BASE + 'clientes/' + $('#cliente_id').val() + '/destroy_cliente_convenio'
            dataType: 'JSON'
            data:
              cliente_convenio_id: link.data().clienteConvenioId
            success: () ->
              # remove linha da tabela_cliente_convenios
              link.closest('tr').find('td').detach()
              return
        return
    false

  # => Alterar Status do Convenio no Cliente
  $('#cliente_convenio_status_convenio').change ->
    if $(this).is(':checked')
      cliente_convenio_id = $(this).val()
      bootbox.confirm
        message: 'Deseja mesmo inativar este Convênio?'
        buttons:
          confirm:
            label: 'Sim'
            className: 'btn-success'
          cancel:
            label: 'Ainda não'
            className: 'btn-danger'
        callback: (result) ->
          if result == true
            $('#cliente_convenio_status_convenio').attr('checked', result)
            $.ajax
              type: 'get'
              url: URL_BASE + "empresa/#{empresa_id}/clientes/#{cliente_id}/inativar_convenio"
              data:
                cliente_convenio_id: cliente_convenio_id
                cliente_id: cliente_id
                status: false
              success: (response) ->
                if $("#agenda_id").text() != "" && $("#sala_espera_id").text() != ""
                  window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}&locale=pt-BR&sala_espera_id=#{sala_espera_id}"
                if $("#agenda_id").text() != "" && $("#sala_espera_id").text() == ""
                  window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}&locale=pt-BR"
          else
            $('#cliente_convenio_status_convenio').attr('checked', result)
    else
      cliente_convenio_id = $(this).val()
      bootbox.confirm
        message: 'Deseja mesmo reativar este Convênio?'
        buttons:
          confirm:
            label: 'Sim'
            className: 'btn-success'
          cancel:
            label: 'Ainda não'
            className: 'btn-danger'
        callback: (result) ->
          if result == true
            $('#cliente_convenio_status_convenio').attr('checked', result)
            $.ajax
              type: 'get'
              url: URL_BASE + "empresa/#{empresa_id}/clientes/#{cliente_id}/ativar_convenio"
              data:
                cliente_convenio_id: cliente_convenio_id
                cliente_id: cliente_id
                status: true
              success: (response) ->
                if $("#agenda_id").text() != "" && $("#sala_espera_id").text() != ""
                  window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}&locale=pt-BR&sala_espera_id=#{sala_espera_id}"
                if $("#agenda_id").text() != "" && $("#sala_espera_id").text() == ""
                  window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}&locale=pt-BR"
          else
            $('#cliente_convenio_status_convenio').attr('checked', result)
    return
