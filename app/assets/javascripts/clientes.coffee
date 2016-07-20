jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  $('#cliente_idade').prop 'disabled', true

  $('#cliente_nascimento').change ->
    verifica_data_nascimento()
    return

  # funcao para verificar valor de data_nascimento e chamar funcao calculaIdade
  verifica_data_nascimento = ->
    campo_idade = undefined
    data_nascimento_informada = undefined
    data_nascimento_informada = $('#cliente_nascimento').val()
    if data_nascimento_informada != null
      campo_idade = calculaIdade(data_nascimento_informada)
      if campo_idade != null
        $('#cliente_idade').val campo_idade
    return

  # funcao que calcula a idade em anos, meses e dias a partir da data_nascimento_informada
  calculaIdade = (data_nascimento_informada) ->
    ano_nascimento = undefined
    dia_nascimento = undefined
    hoje = undefined
    idade = undefined
    mes_nascimento = undefined
    anos_idade = undefined
    dias_idade = undefined
    meses_idade = undefined
    str_ano = undefined
    str_dia = undefined
    str_idade = undefined
    str_mes = undefined
    data_nascimento_informada = data_nascimento_informada.split('/')
    dia_nascimento = data_nascimento_informada[0]
    mes_nascimento = data_nascimento_informada[1]
    mes_nascimento--
    ano_nascimento = data_nascimento_informada[2]
    hoje = new Date
    data_nascimento = new Date(ano_nascimento, mes_nascimento, dia_nascimento)
    differenceInMilisecond = hoje.valueOf() - data_nascimento.valueOf()
    anos_idade = Math.floor(differenceInMilisecond / 31536000000)
    dias_idade = Math.floor(differenceInMilisecond % 31536000000 / 86400000)
    meses_idade = Math.floor(dias_idade / 30)
    dias_idade = dias_idade % 30
    if isNaN(dias_idade) or isNaN(meses_idade) or isNaN(anos_idade)
      return null
    idade =
      anos: anos_idade
      meses: meses_idade
      dias: dias_idade
    if idade.anos == 1
      str_ano = 'ano'
    else
      str_ano = 'anos'
    if idade.meses == 1
      str_mes = 'mês'
    else
      str_mes = 'meses'
    if idade.dias == 1
      str_dia = 'dia'
    else
      str_dia = 'dias'
    str_idade = idade.anos + ' ' + str_ano + ', ' + idade.meses + ' ' + str_mes + ' e ' + idade.dias + ' ' + str_dia
    return str_idade

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
