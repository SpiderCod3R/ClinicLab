$(document).ready ->
  localhost = window.location.origin
  # => Metodo para buscar pacientes já cadastrados no sistema
  $("#cliente_nome").focusout (event) ->
    event.preventDefault()
    paciente = $(this)
    $.ajax
      type: 'get'
      url: localhost + '/search/buscar_pacientes'
      dataType: 'json'
      data: 
        nome_paciente: paciente.attr('value').toUpperCase()
      success: (json) ->
        type = BootstrapDialog.TYPE_DEFAULT
        
        if json.length != 0
          result = montar_resultado_busca_agenda_pacientes(json)
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
        else
          result_box = "Nenhum paciente encontrado.<BR />Preencha todos os campos corretamente."
        
        
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

  montar_resultado_busca_agenda_pacientes = (pacientes) ->
    dados_tabela = []
    x = 0
    while x < pacientes.length
      cluster = pacientes[x]
      dados_tabela.push("<tr><td id='cliente_search_result_link'>"+
                        "<a href='#' data-paciente-nome='#{cluster.nome}'"+
                        "data-paciente-id='#{cluster.id}'"+
                        "data-paciente-rg='#{cluster.rg}'"+
                        "data-paciente-cpf='#{cluster.cpf.numero}'"+
                        "data-paciente-email='#{cluster.email}'"+
                        # "data-paciente-matricula='#{cluster.matricula}'"+
                        "data-paciente-nascimento='#{cluster.nascimento.data}'"+
                        # "data-paciente-validade_carteira='#{cluster.validade_carteira.data}'"+
                        "data-paciente-sexo='#{cluster.sexo}'"+
                        # "data-paciente-produto='#{cluster.produto}'"+
                        # "data-paciente-titular='#{cluster.titular}'"+
                        "data-paciente-endereco='#{cluster.endereco}'"+
                        "data-paciente-complemento='#{cluster.complemento}'"+
                        "data-paciente-bairro='#{cluster.bairro}'"+
                        # "data-paciente-plano='#{cluster.plano}'"+
                        "data-paciente-sexo='#{cluster.sexo}'"+
                        "data-paciente-estado_civil='#{cluster.estado_civil}'"+
                        # "data-paciente-validade_carteira='#{cluster.validade_carteira}'"+
                        "data-paciente-telefone='#{cluster.telefone}'>"+
                        # "data-paciente-convenio_id='#{if cluster.convenio != undefined then cluster.convenio.id }'"+
                        # "data-paciente-convenio_nome='#{if cluster.convenio != undefined then cluster.convenio.nome }'>"+
                        cluster.nome.toUpperCase() + "</a></td>" + 
                        "<td>#{cluster.rg }</td>" +
                        "<td>#{cluster.cpf.numero}</td>" +
                        "</tr>")
      x = x + 1
    dados_tabela

  $(document).on "click", "#cliente_search_result_link", (event) ->
    event.preventDefault()
    link = $(this).find("a")
    $("#cliente_nome").val(link.data().pacienteNome)
    $("#cliente_telefone").val(link.data().pacienteTelefone)
    $("#cliente_email").val(link.data().pacienteEmail)
    $("#cliente_cpf").val(link.data().pacienteCpf)
    $("#cliente_rg").val(link.data().pacienteRg)
    # $("#cliente_matricula").val(link.data().pacienteMatricula)
    # $("#cliente_produto").val(link.data().pacienteProduto)
    $("#cliente_nascimento").val(link.data().pacienteNascimento)
    # $("#cliente_validade_carteira").val(link.data().pacienteNascimento)
    $("#cliente_sexo").val(link.data().pacientesexo)
    # $("#cliente_titular").val(link.data().pacienteTitular)
    # $("#cliente_plano").val(link.data().pacientePlano)
    # $(".cliente_validade_carteira").val(link.data().pacienteValidade_carteira)
    $("#cliente_endereco").val(link.data().pacienteEndereco)
    $("#cliente_complemento").val(link.data().pacienteComplemento)
    $("#cliente_bairro").val(link.data().pacienteBairro)
    $("#cliente_sexo").val(link.data().pacienteSexo)
    $("#cliente_estado_civil").val(link.data().pacienteEstado_civil)

    if link.data().pacienteId != "undefined"
      $("#cliente_id").val(link.data().pacienteId)
    if link.data().pacienteConvenio_id != "undefined"
      $("#cliente_convenio_id").val(link.data().pacienteConvenio_id) #"<option value=\"" + link.data().pacienteEstado_id  + "\">" + link.data().pacienteEstado_nome + "</option>"