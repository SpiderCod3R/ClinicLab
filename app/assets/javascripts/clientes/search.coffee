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
                        "<th>Nome do Cliente</th>"+
                        "<th>RG</th>"+
                        "<th>CPF</th>"+
                      "</tr><thead>"+
                      "<tbody>" +
                        result +
                      "</tbody>" +
                    "</table>"
        else
          result_box = "Nenhum cliente encontrado.<BR />Preencha todos os campos corretamente."


        if result_box != ""
          BootstrapDialog.show
            type: type
            title: 'Cliente(s) encontrados.'
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

  montar_resultado_busca_agenda_pacientes = (clientes) ->
    dados_tabela = []
    x = 0
    cargo_id =0
    cargo_nome =""
    while x < clientes.length
      cluster = clientes[x]
      if cluster.cargo != null
        cargo_id = cluster.cargo.id
        cargo_nome = cluster.cargo.nome

      dados_tabela.push("<tr><td id='cliente_search_result_link'>"+
                        "<a href='#' data-cliente-nome='#{cluster.nome}'"+
                        "data-cliente-status='#{cluster.status}'"+
                        "data-cliente-id='#{cluster.id}'"+
                        "data-cliente-rg='#{cluster.rg}'"+
                        "data-cliente-cpf='#{cluster.cpf.numero}'"+
                        "data-cliente-email='#{cluster.email}'"+
                        "data-cliente-nascimento='#{cluster.nascimento.data}'"+
                        "data-cliente-sexo='#{cluster.sexo}'"+
                        "data-cliente-endereco='#{cluster.endereco}'"+
                        "data-cliente-complemento='#{cluster.complemento}'"+
                        "data-cliente-bairro='#{cluster.bairro}'"+
                        "data-cliente-sexo='#{cluster.sexo}'"+
                        "data-cliente-estado-civil='#{cluster.estado_civil}'"+
                        "data-cliente-cargo-id='#{cargo_id}'"+
                        "data-cliente-cargo-nome='#{cargo_nome}'"+
                        "data-cliente-cidade-id='#{cluster.cidade.id}'"+
                        "data-cliente-cidade-nome='#{cluster.cidade.nome}'"+
                        "data-cliente-estado-id='#{cluster.estado.id}'"+
                        "data-cliente-estado-nome='#{cluster.estado.nome}'"+
                        "data-cliente-nacionalidade='#{cluster.nacionalidade}'"+
                        "data-cliente-naturalidade='#{cluster.naturalidade}'"+
                        "data-cliente-telefone='#{cluster.telefone}'>"+
                        cluster.nome.toUpperCase() + "</a></td>" +
                        "<td>#{cluster.rg }</td>" +
                        "<td>#{cluster.cpf.numero}</td>" +
                        "</tr>")
      x = x + 1
    dados_tabela

  $(document).on "click", "#cliente_search_result_link", (event) ->
    event.preventDefault()
    link = $(this).find("a")
    $("#cliente_nome").val(link.data().clienteNome)
    $("#cliente_telefone").val(link.data().clienteTelefone)
    $("#cliente_email").val(link.data().clienteEmail)
    $("#cliente_cpf").val(link.data().clienteCpf)
    $("#cliente_rg").val(link.data().clienteRg)
    $("#cliente_nascimento").val(link.data().clienteNascimento)
    $("#cliente_endereco").val(link.data().clienteEndereco)
    $("#cliente_complemento").val(link.data().clienteComplemento)
    $("#cliente_bairro").val(link.data().clienteBairro)
    $("#cliente_sexo").val(link.data().clienteSexo)
    $("#cliente_estado_civil").val(link.data().clienteEstadoCivil)
    $("#cliente_nacionalidade").val(link.data().clienteNacionalidade)

    if link.data().clienteStatus != null
      $("#cliente_status").val(link.data().clienteStatus.toString())

    if $('#cliente_nacionalidade :selected').text() == 'Brasil'
      $('#naturalidade_cliente').show()
      $("#cliente_naturalidade").val(link.data().clienteNaturalidade)
    document.getElementById("cliente_estado_id").selectedIndex = link.data().clienteEstadoId
    document.getElementById("cliente_cidade_id").selectedIndex = link.data().clienteCidadeId

    $("#cliente_id").val(link.data().clienteId)
    if link.data().clienteConvenio_id != "undefined"
      $("#cliente_convenio_id").val(link.data().clienteConvenio_id) #"<option value=\"" + link.data().pacienteEstado_id  + "\">" + link.data().pacienteEstado_nome + "</option>"
