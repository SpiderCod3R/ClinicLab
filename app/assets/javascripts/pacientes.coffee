jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  cidades = $('#paciente_cidade_id').html()
  if $('#paciente_estado_id').val() != ""
    $('#paciente_cidade_id').prop 'disabled', false
    estado = $('#paciente_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    $('#paciente_cidade_id').html options
  else
    $('#paciente_cidade_id').prop 'disabled', true

  $('#paciente_estado_id').change ->
    estado = $('#paciente_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    if options
      $('#paciente_cidade_id').html options
      return $('#paciente_cidade_id').prop 'disabled', false
    else
      $('#paciente_cidade_id').empty()
      return $('#paciente_cidade_id').prop 'disabled', true
