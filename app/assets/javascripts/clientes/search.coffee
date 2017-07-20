$(document).ready ->
  localhost = window.location.origin
  window._cliente_convenios_ =[]
  window._option_="create"
  window._usando_agora_cliente_convenio_=false

  # => Metodo para buscar clientes já cadastrados no sistema
  $("#cliente_nome").focusout (event) ->
    event.preventDefault()
    cliente = $(this)
    $.ajax
      type: 'GET'
      url: localhost + '/search/collect_clientes'
      dataType: 'JSON'
      data:
        name: cliente.attr('value').toUpperCase()
      success: (json) ->
        type = BootstrapDialog.TYPE_DEFAULT

        if json.length != 0
          result = montar_resultado_busca_agenda_clientes(json)
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

  montar_resultado_busca_agenda_clientes = (clientes) ->
    dados_tabela = []
    x = 0
    cargo_id =0
    cidade_id=0
    estado_id=0
    cargo_nome =""
    cidade_nome =""
    estado_nome =""
    while x < clientes.length
      cluster = clientes[x]
      if cluster.cargo != null
        cargo_id = cluster.cargo.id
        cargo_nome=cluster.cargo.nome
      if cluster.cidade != null
        cidade_id = cluster.cidade.id
        cidade_nome= cluster.cidade.nome
      if cluster.estado != null
        estado_id = cluster.estado.id
        estado_nome= cluster.estado.nome

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
                        "data-cliente-cidade-id='#{cluster.cidade_id}'"+
                        "data-cliente-cidade-nome='#{cluster.cidade_nome}'"+
                        "data-cliente-estado-id='#{cluster.estado_id}'"+
                        "data-cliente-estado-nome='#{cluster.estado_nome}'"+
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
      $("#cliente_convenio_id").val(link.data().clienteConvenio_id) #"<option value=\"" + link.data().clienteEstado_id  + "\">" + link.data().clienteEstado_nome + "</option>"
    $.ajax
      type: 'GET'
      url: localhost + '/search/find_cliente'
      dataType: 'JSON'
      data:
        id: link.data().clienteId
      success: (response) ->
        montar_tabela_convenios(response, link.data().clienteId)

  montar_tabela_convenios = (response, cliente_id) ->
    x=0
    #=> Limpa a tabela toda hora antes de Entrar adicionando elementos
    # caso o usuario clickar varias vezes no nome desejado no modal com os clientes
    $('#tabela_cliente_convenios').empty()
    while x < response.convenios.length
      request   = response.convenios[x]
      status    = show_status_convenio(request.status_convenio)
      using_now = show_convenio_utilizado(request)
      $('#tabela_cliente_convenios').append "<tr>" +
                                              "<td>#{request.convenio.name}</td>" +
                                              "<td>" +
                                                "<center><a href='#' data-index='#{x}' data-usando_agora='#{request.utilizando_agora}' data-cliente_convenio_id='#{request.id}' data-cliente_id='#{cliente_id}' id='edit_vinculo_cliente_convenio'>" +
                                                  "<i class='fa fa-pencil fa-2x'></i>" +
                                                "</a></center>" +
                                              "</td>" +
                                              "#{using_now}"+
                                              "<td>" +
                                                "<a href='#{request.id}' class=excluir_convenio>" +
                                                  "<center>" +
                                                    "<i class='fa fa-trash fa-2x' aria-hidden='true'></i>" +
                                                  "</center>" +
                                                "</a>" +
                                              "</td>" +
                                            "</tr>"
      _cliente_convenios_.push
        'cliente_convenio_id': request.id
        'convenio_id': request.convenio_id
        'convenio_nome': request.convenio.name
        'matricula': request.matricula
        'validade_carteira': request.data_carteira
        'produto': request.produto
        'titular': request.titular
        'plano': request.plano
        'utilizando_agora': request.utilizando_agora
      x++


  show_status_convenio= (status) ->
    td=""
    if status == true
      td="<td>" +
        "<center>" +
          "<i class='fa fa-check-circle fa-2x'></i>" +
        "</center>" +
      "</td>"
    else
      td= "<td>" +
        "<center>" +
          "<i class='fa fa-times-circle fa-2x'></i>" +
        "</center>" +
      "</td>"
    return td

  show_convenio_utilizado= (request) ->
    td=""
    -if request.utilizando_agora==true
      td="<td>" +
        "<center>" +
          "<input type='checkbox' name='cliente_convenio_status_convenio' id='cliente_convenio_status_convenio' value='#{request.id}' checked>" +
        "</center>" +
      "</td>"
    -if request.utilizando_agora==false
      td="<td>" +
        "<center>" +
          "<input type='checkbox' name='cliente_convenio_status_convenio' id='cliente_convenio_status_convenio' value='#{request.id}'>" +
        "</center>" +
      "</td>"
    return td

  #=> Em uma ficha de um cliente novo quando o cliente já possuir um convenio e
  # o mesmo quiser editar o convenio ainda no cadastrar ele adiciona os campos e
  # a seguir essa funcionalidade continua em cliente_convenios.coffee e finaliza em 
  # $('form.new_cliente') & $('form.edit_cliente')
  $(document).on 'click', "#edit_vinculo_cliente_convenio", ->
    link = $(this).data()
    $(this).closest("tr").find('td').detach()
    $("#cliente_convenio_id").val(link.cliente_convenio_id)
    _usando_agora_cliente_convenio_=link.utilizando_agora
    $.ajax
      type: 'GET'
      url: localhost + '/search/find_cliente_convenio'
      dataType: 'JSON'
      data:
        cliente_convenio_id: link.cliente_convenio_id
        cliente_id: link.cliente_id
      success: (response) ->
        _cliente_convenios_.splice(link.index, 1)
        $("#cliente_convenio_matricula").val(response.convenio.matricula)
        $("#cliente_convenio_convenio_id").val(response.convenio.convenio_id)
        $("#cliente_convenio_validade_carteira").val(response.convenio.data_carteira)
        $("#cliente_convenio_produto").val(response.convenio.produto)
        $("#cliente_convenio_titular").val(response.convenio.titular)
        $("#cliente_convenio_plano").val(response.convenio.plano)
        _option_="edit"
