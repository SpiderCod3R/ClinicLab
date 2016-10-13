$(document).ready ->
  localhost = window.location.origin

  if $('#agenda_movimentacao_sem_convenio').length
    checked_convenio = this.checked ? true : false
    if checked_convenio
      $("#agenda_movimentacao_convenio_id").prop( "disabled", true);
  
  $('#agenda_movimentacao_sem_convenio').change ->
    checked_convenio = this.checked ? true : false
    if checked_convenio
      $("#agenda_movimentacao_convenio_id").prop( "disabled", true);
    else
      $("#agenda_movimentacao_convenio_id").prop( "disabled", false);

  # => Metodo para buscar pacientes já cadastrados no sistema
  $("#agenda_movimentacao_nome_paciente").on 'change', (event) ->
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
                        "<th>Convênio</th>"+
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
      dados_tabela.push("<tr><td id='paciente_search_result_link'>"+
                        "<a href='#' data-paciente-nome='#{cluster.nome}'"+
                        "data-paciente-id='#{cluster.id}'"+
                        "data-paciente-rg='#{cluster.rg}'"+
                        "data-paciente-cpf='#{cluster.cpf}'"+
                        "data-paciente-email='#{cluster.email}'"+
                        "data-paciente-telefone='#{cluster.telefone}'"+
                        "data-paciente-convenio_id='#{if cluster.convenio != undefined then cluster.convenio.id }'"+
                        "data-paciente-convenio_nome='#{if cluster.convenio != undefined then cluster.convenio.nome }'>"+
                        cluster.nome.toUpperCase() + "</a></td>" + 
                        "<td>#{cluster.rg }</td>" +
                        "<td>#{cluster.cpf.numero}</td>" +
                        "<td>#{cluster.convenio.nome}</td>" +
                        "</tr>")
      x = x + 1
    dados_tabela

  $(document).on "click", "#paciente_search_result_link", ->
    link = $(this).find("a")
    $("#agenda_movimentacao_nome_paciente").val(link.data().pacienteNome).focus()
    $("#agenda_movimentacao_telefone_paciente").val(link.data().pacienteTelefone)
    $("#agenda_movimentacao_email_paciente").val(link.data().pacienteEmail)

    if link.data().pacienteId != "undefined"
      $("#agenda_movimentacao_id_paciente").val(link.data().pacienteId)
    if link.data().pacienteConvenio_id != "undefined"
      $("#agenda_movimentacao_convenio_id").val(link.data().pacienteConvenio_id) #"<option value=\"" + link.data().pacienteEstado_id  + "\">" + link.data().pacienteEstado_nome + "</option>"