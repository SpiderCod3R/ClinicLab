$(document).ready ->
  URL_BASE = window.location.origin + '/'

  # quando clicar no botão 'Prosseguir'
  $('#redirect_to_add_servicos').click (event) ->
    status = $('#movimento_servico_status').val()
    cliente_id = $('#movimento_servico_cliente_id').val()
    convenio_id = $('#movimento_servico_convenio_id').val()
    solicitante_id = $('#movimento_servico_solicitante_id').val()
    medico_id = $('#movimento_servico_medico_id').val()
    data_entrada = $('#movimento_servico_data_entrada').val()
    hora_entrada = $('#movimento_servico_hora_entrada').val()
    # passa os dados para o controller
    $.ajax
      type: 'POST'
      url: URL_BASE + 'movimento_servicos/prosseguir_servicos'
      dataType: 'JSON'
      data:
        status: status
        cliente_id: cliente_id
        convenio_id: convenio_id
        solicitante_id: solicitante_id
        medico_id: medico_id
        data_entrada: data_entrada
        hora_entrada: hora_entrada
      success: (json) ->
        window.location.href = URL_BASE + 'empresa/' + json["empresa_id"] + '/movimento_servicos/' + json["movimento_servico_id"] + '/add_servicos'
        return
    return

  # quando clicar no botão 'Prosseguir'
  $('#redirect_to_edit_servicos').click (event) ->
    id = $('#movimento_servico_id').val()
    status = $('#movimento_servico_status').val()
    cliente_id = $('#movimento_servico_cliente_id').val()
    convenio_id = $('#movimento_servico_convenio_id').val()
    solicitante_id = $('#movimento_servico_solicitante_id').val()
    medico_id = $('#movimento_servico_medico_id').val()
    data_entrada = $('#movimento_servico_data_entrada').val()
    hora_entrada = $('#movimento_servico_hora_entrada').val()
    # passa os dados para o controller
    $.ajax
      type: 'POST'
      url: URL_BASE + 'movimento_servicos/prosseguir_servicos'
      dataType: 'JSON'
      data:
        id: id
        status: status
        cliente_id: cliente_id
        convenio_id: convenio_id
        solicitante_id: solicitante_id
        medico_id: medico_id
        data_entrada: data_entrada
        hora_entrada: hora_entrada
      success: (json) ->
        window.location.href = URL_BASE + 'empresa/' + json["empresa_id"] + '/movimento_servicos/' + json["movimento_servico_id"] + '/edit_servicos'
        return
    return