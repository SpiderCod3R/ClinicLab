jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  $(".fornecedor_cpf").hide()
  $(".fornecedor_cnpj").hide()

  $('#fornecedor_documento').change ->
    value = undefined
    value = $('#fornecedor_documento').val()
    if value == 1
      $('.fornecedor_cpf').fadeIn()
      $('.fornecedor_cnpj').hide()
    else if value == 2
      $('.fornecedor_cpf').hide()
      $('.fornecedor_cnpj').fadeIn()

  cidades = $('#fornecedor_cidade_id').html()
  if $('#fornecedor_estado_id').val() != ""
    $('#fornecedor_cidade_id').prop 'disabled', false
    estado = $('#fornecedor_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    $('#fornecedor_cidade_id').html options
  else
    $('#fornecedor_cidade_id').prop 'disabled', true

  $('#fornecedor_estado_id').change ->
    estado = $('#fornecedor_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    if options
      $('#fornecedor_cidade_id').html options
      return $('#fornecedor_cidade_id').prop 'disabled', false
    else
      $('#fornecedor_cidade_id').empty()
      return $('#fornecedor_cidade_id').prop 'disabled', true
