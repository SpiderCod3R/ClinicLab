$(document).ready ->
  URL_BASE = window.location.origin + '/'
  dados_servicos = []
  valor_total_salvo = 0.00
  valor_total_atual = 0.00
  valor_total_a_pagar = 0.00
  somatorio_servicos_tabela = 0.00
  valor_desconto = 0.00
  valor_desconto_salvo = 0.00

  formata_valor = (v) ->
    v.toFixed(2).replace(',', '').replace '.', ','

  converte_float = (v) ->
    parseFloat v.replace('.', '').replace(',', '.')

  # pega valor_total salvo na tabela movimento_servicos
  if $('#movimento_servico_valor_total').length
    valor_total_salvo = converte_float($('#movimento_servico_valor_total').val())
    # if !isNaN(valor_total_salvo)
    #   valor_total_atual = valor_total_salvo
  # pega valor_desconto salvo na tabela movimento_servicos
  if $('#movimento_servico_valor_desconto').length
    valor_desconto_salvo = converte_float($('#movimento_servico_valor_desconto').val())

  # calcula valor_total
  calcula_valor_total = ->
    desconto = converte_float($('#movimento_servico_valor_desconto').val())
    if isNaN(desconto)
      desconto = 0.0
    # subtrai desconto do valor_total_atual
    valor_total_a_pagar = valor_total_atual - desconto
    # coloca o resultado no campo valor_total
    $('#movimento_servico_valor_total').val formata_valor(valor_total_a_pagar)
    return

  # quando um serviço for selecionado
  $('#movimento_servico_servico_servico_id').change ->
    # limpa campos
    $('#movimento_servico_valor_servico').val('')
    # pega id do serviço selecionado
    servico_id = $('#movimento_servico_servico_servico_id option:selected').val()
    if servico_id != ""
      # passa os dados para o controller
      $.ajax
        type: 'POST'
        url: URL_BASE + 'movimento_servicos/retorna_servico'
        dataType: 'JSON'
        data:
          servico_id: servico_id
        success: (json) ->
          valor_servico = json.toFixed(2).replace(",", "").replace(".", ",")
          $('#movimento_servico_valor_servico').val(valor_servico)
          return

  # quando clicar no botão '+'
  $('#adicionar_servico_em_movimento_servico').click (event) ->
    event.preventDefault()
    error_messages = []
    if $('#movimento_servico_servico_servico_id option:selected').val() == undefined
      error_messages.push('<li>Serviço deve ser selecionado</li>')
    if $('#movimento_servico_valor_servico').val() == ''
      error_messages.push('<li>Valor Serviço deve ser preenchido</li>')
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
      adiciona_linha_tabela_servicos()
      limpa_campos_movimento_servico_servicos()
    return

  adiciona_linha_tabela_servicos = ->
    # pegando valores dos campos
    id_servico = $('#movimento_servico_servico_servico_id option:selected').val()
    tipo_servico = $('#movimento_servico_servico_servico_id option:selected').text()
    valor_servico = converte_float($('#movimento_servico_valor_servico').val())
    # montando a tabela
    $('#tabela_movimento_servicos').append '<tr><td>' + tipo_servico + '</td><td>' + formata_valor(valor_servico) + '</td><td><a href="' + id_servico + '" class="excluir_servico"><center><div id="icon-trash"></div></center></a></td>' + '</tr>'
    # armazenando os valores em um array
    dados_servicos.push
      'servico_id': id_servico
      'servico_tipo': tipo_servico
      'servico_valor': valor_servico
    # fazendo calculo do valor_total
    somatorio_servicos_tabela = somatorio_servicos_tabela + valor_servico
    valor_total_atual = valor_total_salvo + valor_desconto_salvo + somatorio_servicos_tabela
    calcula_valor_total()
    return

  # limpa campos apos colocar dados na tabela
  limpa_campos_movimento_servico_servicos = ->
    $('#movimento_servico_servico_servico_id').val('').trigger('change')
    $('#movimento_servico_valor_servico').val('')
    return

  # quanto modificado o desconto, refaz o calculo do valor_total
  $('#movimento_servico_valor_desconto').change ->
    valor_total_atual = valor_total_salvo + valor_desconto_salvo + somatorio_servicos_tabela
    calcula_valor_total()
    return

  # remove serviço recém-adicionado da tabela e do array
  $(document).on 'click', '.excluir_servico', (event) ->
    event.preventDefault()
    i = 0
    while i < dados_servicos.length
      if parseInt($(this).attr('href')) == parseInt(dados_servicos[i]['servico_id'])
        valor_servico_excluido = dados_servicos[i]['servico_valor']
        dados_servicos.splice i, 1
        $(this).closest('tr').fadeOut()
        calcula_valor_apos_exclusao(valor_servico_excluido)
      i = i + 1
    false

  # exclui o serviço salvo no bd
  $(document).on 'click', '.delete_movimento_servico_servico', (event) ->
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
            url: URL_BASE + 'movimento_servicos/' + $('#movimento_servico_id').val() + '/destroy_movimento_servico_servico'
            dataType: 'JSON'
            data:
              movimento_servico_servico_id: link.data().movimentoServicoServicoId
            success: (json) ->
              # remove linha da tabela_movimento_servico_servicos
              link.closest('tr').find('td').detach()
              $('#movimento_servico_valor_total').val(formata_valor(json))
              valor_total_salvo = json
              return
        return
    false

  # refaz o calculo do valor_total apos a exclusao de um servico da tabela
  calcula_valor_apos_exclusao = (valor_servico_excluido) ->
    valor_total_anterior = converte_float($('#movimento_servico_valor_total').val())
    valor_total_atual = valor_total_anterior - valor_servico_excluido
    $('#movimento_servico_valor_total').val(formata_valor(valor_total_atual))
    return

  $('form.edit_movimento_servico').submit (event) ->
    event.preventDefault()
    if dados_servicos.length > 0
      $.ajax
        type: 'POST'
        url: URL_BASE + 'movimento_servicos/salva_movimento_servico_servicos'
        dataType: 'JSON'
        data:
          servicos_attributes: dados_servicos
        success: () ->
          $('form.edit_movimento_servico').unbind('submit').submit()
          return
      return
    else
      $('form.edit_movimento_servico').unbind('submit').submit()
      return

  return