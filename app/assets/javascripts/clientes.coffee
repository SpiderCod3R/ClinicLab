jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  cidades = $('#cliente_cidade_id').html()
  if $('#cliente_estado_id').val() != ""
    $('#cliente_cidade_id').prop 'disabled', false
    estado = $('#cliente_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    $('#cliente_cidade_id').html options
  else
    $('#cliente_cidade_id').prop 'disabled', true

  $('#cliente_estado_id').change ->
    estado = $('#cliente_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    if options
      $('#cliente_cidade_id').html options
      return $('#cliente_cidade_id').prop 'disabled', false
    else
      $('#cliente_cidade_id').empty()
      return $('#cliente_cidade_id').prop 'disabled', true
