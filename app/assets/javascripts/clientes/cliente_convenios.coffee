$(document).ready ->
  URL_BASE = window.location.origin + '/'
  dados_convenios = []
  cliente_convenio_id = 0
  agenda_id = $("#agenda_id").text()
  sala_espera_id = $("#sala_espera_id").text()
  empresa_id = $("#empresa_id").text()
  cliente_id = $("#cliente_id").val()

  $('#adicionar_convenio_em_cliente').click (event) ->
    event.preventDefault()
    error_messages = []
    if $('#cliente_convenio_status_convenio_true:checked').val() == undefined
      if $('#cliente_convenio_status_convenio_false:checked').val() == undefined
        error_messages.push('<li>Status Convênio deve ser selecionado</li>')
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
    return

  adiciona_linha_tabela_convenios = ->
    # pegando valores dos campos
    id_convenio = $('#cliente_convenio_convenio_id option:selected').val()
    nome_convenio = $('#cliente_convenio_convenio_id option:selected').text()
    if $('#cliente_convenio_status_convenio_true:checked').val() != undefined
      status_convenio = true
    if $('#cliente_convenio_status_convenio_false:checked').val() != undefined
      status_convenio = false
    matricula = $('#cliente_convenio_matricula').val()
    validade_carteira = $('#cliente_convenio_validade_carteira').val()
    produto = $('#cliente_convenio_produto').val()
    titular = $('#cliente_convenio_titular').val()
    plano = $('#cliente_convenio_plano').val()
    # montando a tabela
    $('#tabela_cliente_convenios').append "<tr>" +
                                            "<td>#{nome_convenio}</td>" +
                                            "<td></td>" +
                                            "<td></td>" +
                                            "<td></td>" +
                                            "<td>" + 
                                              "<a href='#{id_convenio}' class=excluir_convenio>" +
                                                "<center>" +
                                                  "<div id='icon-trash'></div>" +
                                                "</center>" +
                                              "</a>" +
                                            "</td>" +
                                          "</tr>"
    # armazenando os valores em um array
    dados_convenios.push
      'convenio_id': id_convenio
      'convenio_nome': nome_convenio
      'status_convenio': status_convenio
      'matricula': matricula
      'validade_carteira': validade_carteira
      'produto': produto
      'titular': titular
      'plano': plano
    return

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
    while i < dados_convenios.length
      if parseInt($(this).attr('href')) == parseInt(dados_convenios[i]['convenio_id'])
        dados_convenios.splice i, 1
        $(this).closest('tr').fadeOut()
      i = i + 1
    false

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

  $('form.edit_cliente').submit (event) ->
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: URL_BASE + 'clientes/salva_cliente_convenios'
      dataType: 'JSON'
      data:
        convenios_attributes: dados_convenios
      success: () ->
        $('form.edit_cliente').unbind('submit').submit()
        return
    return

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
              success: (response) ->
                if $("#agenda_id").text() != "" && $("#sala_espera_id").text() != ""
                  window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}&locale=pt-BR&sala_espera_id=#{sala_espera_id}"
                if $("#agenda_id").text() != "" && $("#sala_espera_id").text() == ""
                  window.location.href = URL_BASE + "empresa/#{empresa_id}/ficha_cliente?agenda_id=#{agenda_id}&cliente_id=#{cliente_id}&locale=pt-BR"
          else
            $('#cliente_convenio_status_convenio').attr('checked', result)
    return

