jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  cidades = $('#profissional_cidade_id').html()
  if $('#profissional_estado_id').val() != ""
    $('#profissional_cidade_id').prop 'disabled', false
    estado = $('#profissional_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    $('#profissional_cidade_id').html options
  else
    $('#profissional_cidade_id').prop 'disabled', true

  $('#profissional_estado_id').change ->
    estado = $('#profissional_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    if options
      $('#profissional_cidade_id').html options
      return $('#profissional_cidade_id').prop 'disabled', false
    else
      $('#profissional_cidade_id').empty()
      return $('#profissional_cidade_id').prop 'disabled', true
