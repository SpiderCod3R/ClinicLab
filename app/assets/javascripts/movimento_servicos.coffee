$(document).ready ->
  URL_BASE = window.location.origin + '/'
  dados_servicos = []
  valor_total_salvo = 0.00
  valor_total_atual = 0.00
  valor_total_a_pagar = 0.00
  somatorio_servicos_tabela = 0.00
  valor_desconto = 0.00
  valor_desconto_salvo = 0.00
  valor_servicos = 0.00
  valor_servicos_salvo = 0.00

  formata_valor = (v) ->
    v.toFixed(2).replace(',', '').replace '.', ','

  converte_float = (v) ->
    parseFloat v.replace('.', '').replace(',', '.')

  # pega valor_total salvo na tabela movimento_servicos
  if $('#movimento_servico_valor_total').length
    if $('#movimento_servico_valor_total').val().length > 0
      valor_total_salvo = converte_float($('#movimento_servico_valor_total').val())
  # pega valor_servicos salvo na tabela movimento_servicos
  if $('#movimento_servico_valor_servicos').length
    if $('#movimento_servico_valor_servicos').val().length > 0
      valor_servicos_salvo = converte_float($('#movimento_servico_valor_servicos').val())
      if !isNaN(valor_servicos_salvo)
        valor_total_atual = valor_servicos_salvo
  # pega valor_desconto salvo na tabela movimento_servicos
  if $('#movimento_servico_valor_desconto').length
    if $('#movimento_servico_valor_desconto').val().length > 0
      valor_desconto_salvo = converte_float($('#movimento_servico_valor_desconto').val())

  # calcula valor_total
  calcula_valor_total = ->
    desconto = converte_float($('#movimento_servico_valor_desconto').val())
    if isNaN(desconto)
      desconto = 0.0
    # subtrai desconto do valor_total_atual
    valor_total_a_pagar = valor_total_atual - desconto
    # coloca o valor_total_atual no campo valor_servicos
    $('#movimento_servico_valor_servicos').val(formata_valor(valor_total_atual))
    # coloca o valor com desconto no campo valor_total
    $('#movimento_servico_valor_total').val(formata_valor(valor_total_a_pagar))
    # verifica se desconto maior que o valor a pagar
    if desconto > valor_total_atual
      return BootstrapDialog.show
        type: BootstrapDialog.TYPE_DANGER
        title: 'AVISO!'
        message: 'Valor Desconto ?? maior que Valor Servi??os. Tem certeza?'
        closable: false
        draggable: true
        buttons: [ {
          label: 'Sim'
          action: (dialogRef) ->
            dialogRef.close()
            false
        }, {
          label: 'N??o'
          action: (dialogRef) ->
            dialogRef.close()
            $('#movimento_servico_valor_desconto').focus()
            false
        } ]
    return

  # quando um servi??o for selecionado
  $('#movimento_servico_servico_servico_id').change ->
    # limpa campos
    $('#movimento_servico_valor_servico').val('')
    # pega id do servi??o selecionado
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
      return

  # quando clicar no bot??o '+'
  $('#adicionar_servico_em_movimento_servico').click (event) ->
    event.preventDefault()
    error_messages = []
    if $('#movimento_servico_servico_servico_id option:selected').val() == undefined
      error_messages.push('<li>Servi??o deve ser selecionado</li>')
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
    valor_total_atual = valor_servicos_salvo + somatorio_servicos_tabela
    calcula_valor_total()
    return

  # limpa campos apos colocar dados na tabela
  limpa_campos_movimento_servico_servicos = ->
    $('#movimento_servico_servico_servico_id').val('').trigger('change')
    $('#movimento_servico_valor_servico').val('')
    return

  # quanto modificado o desconto, refaz o calculo do valor_total
  $('#movimento_servico_valor_desconto').focusout ->
    valor_total_atual = valor_servicos_salvo + somatorio_servicos_tabela
    calcula_valor_total()
    return

  # remove servi??o rec??m-adicionado da tabela e do array
  $(document).on 'click', '.excluir_servico', (event) ->
    event.preventDefault()
    i = 0
    while i < dados_servicos.length
      if parseInt($(this).attr('href')) == parseInt(dados_servicos[i]['servico_id'])
        valor_servico_excluido = dados_servicos[i]['servico_valor']
        dados_servicos.splice i, 1
        $(this).closest('tr').fadeOut()
        somatorio_servicos_tabela = somatorio_servicos_tabela - valor_servico_excluido
        calcula_valor_apos_exclusao()
      i = i + 1
    false

  # exclui o servi??o salvo no bd
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
            url: URL_BASE + 'empresa/' + link.data().empresaId + '/movimento_servicos/' + $('#movimento_servico_id').val() + '/destroy_movimento_servico_servico'
            dataType: 'JSON'
            data:
              movimento_servico_servico_id: link.data().movimentoServicoServicoId
            success: (json) ->
              # pega valor do movimento_servico_servicos excluido
              valor_servico_excluido = link.data().movimentoServicoServicoValor
              # remove linha da tabela_movimento_servico_servicos
              link.closest('tr').find('td').detach()
              # chama metodo que refaz o calculo do valor_total
              valor_servicos_salvo = valor_servicos_salvo - valor_servico_excluido
              calcula_valor_apos_exclusao()
              return
    false

  # refaz o calculo do valor_total apos a exclusao de um servico da tabela
  calcula_valor_apos_exclusao = ->
    # calculando valor_total_atual
    valor_total_atual = valor_servicos_salvo + somatorio_servicos_tabela
    $('#movimento_servico_valor_servicos').val(formata_valor(valor_total_atual))
    # verificando se valor_total_atual igual ou menor que zero
    if (valor_total_atual <= 0.00)
      valor_desconto = 0.00
      valor_total_atual = 0.00
      $('#movimento_servico_valor_desconto').val(formata_valor(valor_desconto))
      $('#movimento_servico_valor_total').val(formata_valor(valor_total_atual))
    else
      calcula_valor_total()
      return

  # validacao dos campos obrigatorios
  valida_campos_form = ->
    error_messages = []
    if $('#movimento_servico_status option:selected').val() == ""
      error_messages.push('<li>Status deve ser selecionado</li>')
    if $('#movimento_servico_cliente_id option:selected').val() == ""
      error_messages.push('<li>Cliente deve ser selecionado</li>')
    if $('#movimento_servico_convenio_id option:selected').val() == ""
      error_messages.push('<li>Conv??nio deve ser selecionado</li>')
    if $('#movimento_servico_solicitante_id option:selected').val() == ""
      error_messages.push('<li>Solicitante deve ser selecionado</li>')
    if $('#movimento_servico_medico_id option:selected').val() == ""
      error_messages.push('<li>M??dico deve ser selecionado</li>')
    return error_messages

  $('form.new_movimento_servico').submit (event) ->
    event.preventDefault()
    error_messages = valida_campos_form()
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
      if dados_servicos.length == 0
        error_messages.push("?? necess??rio que haja pelo menos um Servico relacionado a este Movimento Servi??o")
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
        $('form.new_movimento_servico').unbind('submit').submit()
    return

  $('form.edit_movimento_servico').submit (event) ->
    event.preventDefault()
    error_messages = valida_campos_form()
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

  return