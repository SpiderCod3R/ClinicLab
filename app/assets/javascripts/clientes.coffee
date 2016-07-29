jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  $('#cliente_estado_id').change ->
    estado = $('#cliente_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    if options
      $('#cliente_cidade_id').html options
      $('#cliente_cidade_id').prop 'disabled', false
      return
    else
      $('#cliente_cidade_id').empty()
      $('#cliente_cidade_id').prop 'disabled', true
      return

  cidades = $('#cliente_cidade_id').html()
  if $('#cliente_estado_id').val() != ""
    $('#cliente_cidade_id').prop 'disabled', false
    estado = $('#cliente_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    $('#cliente_cidade_id').html options
  else
    $('#cliente_cidade_id').prop 'disabled', true