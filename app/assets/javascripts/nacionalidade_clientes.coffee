jQuery ->
  if $('#cliente_nacionalidade').val() != ""
    if $('#cliente_nacionalidade :selected').text() == 'Brasil'
      $('#naturalidade_cliente').show()
    else
      $('#naturalidade_cliente').hide()
      $('#cliente_naturalidade').val('').trigger('change')
    return
  $('#cliente_nacionalidade').change ->
    if $('#cliente_nacionalidade :selected').text() == 'Brasil'
      $('#naturalidade_cliente').show()
    else
      $('#naturalidade_cliente').hide()
      $('#cliente_naturalidade').val('').trigger('change')
    return