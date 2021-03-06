#=require clientes/_init_
$(document).ready ->
  cliente_convenio_id = 0
  _cliente_convenios_ =[]
  _option_ = "create"
  agenda_id = $("#agenda_id").text()
  sala_espera_id = $("#sala_espera_id").text()
  empresa_id = $("#empresa_id").text()
  cliente_id = $("#cliente_id").val()
  cliente_convenio_utilizando_agora= false

  # $(document).on 'change', '#cliente_convenio_utilizando_agora', (event) ->
  #   # cliente_convenio_utilizando_agora = this.checked

  $(document).on 'click', '#adicionar_convenio_em_cliente', (event) ->
    event.preventDefault()
    error_messages = []
    if $('#cliente_convenio_convenio_id option:selected').text() == "Selecione"
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
                                          "</tr>"

    console.log cliente_convenio_utilizando_agora
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
      'via': $('#cliente_convenio_via').val()
      'observacoes': $('#cliente_convenio_observacoes').val()
      'utilizando_agora': cliente_convenio_utilizando_agora
      'option': _option_

  limpa_campos_cliente_convenios = ->
    $('#cliente_convenio_convenio_id').val('').trigger('change')
    $('#cliente_convenio_status_convenio_true:checked').prop('checked', false)
    $('#cliente_convenio_status_convenio_false:checked').prop('checked', false)
    $('#cliente_convenio_matricula').val('')
    $('#cliente_convenio_validade_carteira').val('')
    $('#cliente_convenio_produto').val('')
    $('#cliente_convenio_titular').val('')
    $('#cliente_convenio_plano').val('')
    $('#cliente_convenio_via').val('')
    $('#cliente_convenio_observacoes').val('')
    return

  # OBSERVAÇAO
  # Este metodo só é chamado quando os convenios estão sendo
  # Carregados diretamente do banco de dados
  $(document).on 'click', '#change_convenio_cliente', (event) ->
    event.preventDefault()
    resource = $(this)

    $("#cliente_convenio_id").val(resource.data().clienteConvenioId)
    $("#cliente_convenio_convenio_id option[value='#{resource.data().convenioId}']").prop('selected', true)
    $("#cliente_convenio_matricula").val(resource.data().convenioMatricula)
    $("#cliente_convenio_validade_carteira").val(resource.data().convenioValidade)
    $("#cliente_convenio_produto").val(resource.data().convenioProduto)
    $("#cliente_convenio_titular").val(resource.data().convenioTitular)
    $("#cliente_convenio_plano").val(resource.data().convenioPlano)
    $('#cliente_convenio_via').val(resource.data().convenioVia)
    $('#cliente_convenio_observacoes').val(resource.data().convenioObservacoes)
    cliente_convenio_utilizando_agora = resource.data().utilizandoAgora
    resource.closest('tr').find('td').hide()
    _option_="edit"

  # OBSERVAÇAO
  $(document).on 'click', "#edit_vinculo_cliente_convenio", (event), ->
    event.preventDefault()
    link = $(this).data()
    $(this).closest("tr").find('td').detach()
    $("#cliente_convenio_id").val(link.cliente_convenio_id)
    _usando_agora_cliente_convenio_=link.utilizando_agora
    $.ajax
      type: 'GET'
      url: LOCALHOST + 'search/find_cliente_convenio'
      dataType: 'JSON'
      data:
        cliente_convenio_id: link.cliente_convenio_id
        cliente_id: link.cliente_id
      success: (response) ->
        _cliente_convenios_.splice(link.index, 1)
        $("#cliente_convenio_matricula").val(response.convenio.matricula)
        $("#cliente_convenio_convenio_id").val(response.convenio.convenio_id)
        $("#cliente_convenio_validade_carteira").val(response.convenio.data_carteira)
        $("#cliente_convenio_produto").val(response.convenio.produto)
        $("#cliente_convenio_titular").val(response.convenio.titular)
        $("#cliente_convenio_plano").val(response.convenio.plano)
        cliente_convenio_utilizando_agora = link.utilizandoAgora
        console.log cliente_convenio_utilizando_agora
        _option_="edit"


  $('form.edit_cliente').submit (event) ->
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: LOCALHOST + 'clientes/cria_session_cliente_convenios'
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
      url: LOCALHOST + 'clientes/cria_session_cliente_convenios'
      dataType: 'JSON'
      data:
        convenios_attributes: _cliente_convenios_
        option: _option_
      success: () ->
        $('form.new_cliente').unbind('submit').submit()
        return
    return
