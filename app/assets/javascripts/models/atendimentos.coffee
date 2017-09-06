$(document).ready ->
  WINDOW = window
  DOCUMENT = document
  URL_BASE = window.location.origin + "/"

  dados_busca = []
  link=""

  $('#atendimento_nome').on 'change', (event) ->
    paciente = $(this)
    $.ajax
      type: 'get'
      url: URL_BASE + 'search/buscar_pacientes'
      dataType: 'json'
      data: 
        nome_paciente: paciente.attr('value').toUpperCase()
      success: (json) ->
        pacientes_array = json

        type = BootstrapDialog.TYPE_DEFAULT
        result = montar_tabelas_pacientes(json)
        result_box = "<table class='table'>"+
                      "<thead><tr>"+
                        "<th>Nome do Paciente</th>"+
                        "<th>RG</th>"+
                        "<th>CPF</th>"+
                      "</tr><thead>"+
                      "<tbody>" +
                        result +
                      "</tbody>" +
                    "</table>"
        if result_box != ""
          BootstrapDialog.show
            type: type
            title: 'Paciente(s) encontrados.'
            message: result_box.replace(",","")
            closable: false,
            draggable: true,
            buttons: [{
               label: 'Fechar',
               cssClass: 'btn-primary',
               autospin: false,
               action: (dialogRef) ->
                dialogRef.close()
                return false
            }]

  montar_tabelas_pacientes = (pacientes) ->
    dados_tabela = []
    x = 0
    while x < pacientes.length
      cluster = pacientes[x]
      dados_tabela.push("<tr><td id='dialog_search_result_link'>"+
                        "<a href='#' data-paciente-nome='#{cluster.nome}'"+
                        "data-paciente-id='#{cluster.id}'"+
                        "data-paciente-rg='#{cluster.rg}'"+
                        "data-paciente-cpf='#{cluster.cpf}'"+
                        "data-paciente-nome_da_mae='#{cluster.nome_da_mae}'"+
                        "data-paciente-telefone='#{cluster.telefone}'"+
                        "data-paciente-celular='#{cluster.celular}'"+
                        "data-paciente-data_nascimento='#{cluster.nascimento.data}'"+
                        "data-paciente-endereco='#{cluster.endereco}'"+
                        "data-paciente-bairro='#{cluster.bairro}'"+
                        "data-paciente-cep='#{cluster.cep}'"+
                        "data-paciente-cidade_id='#{cluster.cidade.id}'"+
                        "data-paciente-cidade_nome='#{cluster.cidade.nome}'"+
                        "data-paciente-estado_id='#{cluster.estado.id}'"+
                        "data-paciente-estado_nome='#{cluster.estado.nome}'"+
                        "data-paciente-convenio_id='#{if cluster.convenio != undefined then cluster.convenio.id }'"+
                        "data-paciente-convenio_nome='#{if cluster.convenio != undefined then cluster.convenio.nome }'>"+
                        cluster.nome.toUpperCase() + "</a></td>" + 
                        "<td>#{cluster.rg }</td>" +
                        "<td>#{cluster.cpf}</td>" +
                        "</tr>")
      x = x + 1
    dados_tabela

  $(DOCUMENT).on "click", "#dialog_search_result_link", ->
    link = $(this).find("a")
    $("#atendimento_paciente_id").val(link.data().pacienteId)
    $("#atendimento_nome").val(link.data().pacienteNome).focus()
    $("#atendimento_nome_da_mae").val(link.data().pacienteNome_da_mae)
    $("#atendimento_telefone").val(link.data().pacienteTelefone)
    $("#atendimento_celular").val(link.data().pacienteCelular)
    $("#atendimento_data_nascimento").val(link.data().pacienteData_nascimento)
    $("#atendimento_cpf").val(link.data().pacienteCpf)
    $("#atendimento_cep").val(link.data().pacienteCep)
    $("#atendimento_rg").val(link.data().pacienteRg)
    $("#atendimento_endereco").val(link.data().pacienteEndereco)
    $("#atendimento_bairro").val(link.data().pacienteBairro)

    if link.data().pacienteConvenio_id != "undefined"
      $("#atendimento_convenio_id").val(link.data().pacienteConvenio_id) #"<option value=\"" + link.data().pacienteConvenio_id + "\">" + link.data().pacienteConvenio_nome + "</option>"
    if link.data().pacienteEstado_id != "undefined"
      $("#atendimento_estado_id").val(link.data().pacienteEstado_id) #"<option value=\"" + link.data().pacienteEstado_id  + "\">" + link.data().pacienteEstado_nome + "</option>"
    if link.data().pacienteCidade_id != "undefined"
      $('#atendimento_cidade_id').prop 'disabled', false
      cidades = $('#atendimento_cidade_id').html()
      estado = $("#atendimento_estado_id").val()
      console.log estado
      escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
      options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
      $("#atendimento_cidade_id").val(link.data().pacienteCidade_id) #"<option value=\"" + link.data().pacienteCidade_id  + "\">" + link.data().pacienteCidade_nome + "</option>"
      # $('#atendimento_cidade_id').html options
    $("#atendimento_nome_da_mae").focus()
    false

jQuery ->
  cidades = undefined
  estado = undefined
  escaped_estados = undefined
  options = undefined

  cidades = $('#atendimento_cidade_id').html()
  if $('#atendimento_estado_id').val() != ""
    $('#atendimento_cidade_id').prop 'disabled', false
    estado = $('#atendimento_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    $('#atendimento_cidade_id').html options
  else
    $('#atendimento_cidade_id').prop 'disabled', true

  $('#atendimento_estado_id').change ->
    estado = $('#atendimento_estado_id :selected').text()
    escaped_estados = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter('optgroup[label=\'' + escaped_estados + '\']').html()
    if options
      $('#atendimento_cidade_id').html options
      return $('#atendimento_cidade_id').prop 'disabled', false
    else
      $('#atendimento_cidade_id').empty()
      return $('#atendimento_cidade_id').prop 'disabled', true
