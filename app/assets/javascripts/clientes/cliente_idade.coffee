#= require clientes/_init_

jQuery ->
  $('#cliente_idade').prop 'disabled', true

  if $('#cliente_nascimento').length > 0
    if $('#cliente_nascimento').val().length > 0
      verifica_data_nascimento()
  $('#cliente_nascimento').change ->
    verifica_data_nascimento()
