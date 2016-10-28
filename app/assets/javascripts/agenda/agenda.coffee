$(document).ready ->
  dias_semana = 6
  atendimento_sabado   =$("#atendimento_sabado").find("input:checked").val()
  atendimento_domingo  =$("#atendimento_sabado").find("input:checked").val()
  # horario_parcial      =$("#horario_parcial").find("input:checked").val()
  empresa_id = $("#agenda_empresa_id").val()
  localhost = window.location.origin

  $('#q_agenda_movimentacao_nome_paciente_cont').bind 'railsAutocomplete.select', (event, data) ->
    $('#search-form').submit()
    return

  $("#q_data_cont").val("")

  # => arrays necessarios para coletar informação dos horarios
  horarios_tarde =[]
  horarios_manha =[]

  #dia_5 -> Sabado
  $('#manha_dia_5').hide()
  $('#tarde_dia_5').hide()

  #dia_6 -> Domingo
  $('#manha_dia_6').hide()
  $('#tarde_dia_6').hide()

  if $("#manha_dia_0").length
    $("#dia_0").append("Segunda-Feira")
  if $("#manha_dia_1").length
    $("#dia_1").append("Terça-Feira")
  if $("#manha_dia_2").length
    $("#dia_2").append("Quarta-Feira")
  if $("#manha_dia_3").length
    $("#dia_3").append("Quinta-Feira")
  if $("#manha_dia_4").length
    $("#dia_4").append("Sexta-Feira")
  if $("#manha_dia_5").length
    $("#dia_5").append("Sábado")
  if $("#manha_dia_6").length
    $("#dia_6").append("Domingo")

  if $("#tarde_dia_0").length
    $("#tarde_0").append("Segunda-Feira")
  if $("#tarde_dia_1").length
    $("#tarde_1").append("Terça-Feira")
  if $("#tarde_dia_2").length
    $("#tarde_2").append("Quarta-Feira")
  if $("#tarde_dia_3").length
    $("#tarde_3").append("Quinta-Feira")
  if $("#tarde_dia_4").length
    $("#tarde_4").append("Sexta-Feira")
  if $("#tarde_dia_5").length
    $("#tarde_5").append("Sábado")
  if $("#tarde_dia_6").length
    $("#tarde_6").append("Domingo")

  $('#atendimento_sabado').change ->
    atendimento_sabado = $('#atendimento_sabado').find("input:checked").val()
    if atendimento_sabado == "1"
      $('#manha_dia_5').show().fadeIn(500)
      $('#tarde_dia_5').show().fadeIn(500)
    else
      $('#manha_dia_5').show().fadeOut(500)
      $('#tarde_dia_5').show().fadeOut(500)

  $('#atendimento_domingo').change ->
    atendimento_domingo = $('#atendimento_domingo').find("input:checked").val()
    if atendimento_domingo == "1"
      $('#manha_dia_6').show().fadeIn(500)
      $('#tarde_dia_6').show().fadeIn(500)
    else
      $('#manha_dia_6').show().fadeOut(500)
      $('#tarde_dia_6').show().fadeOut(500)

  # $('#horario_parcial').change ->
  #   horario_parcial = $('#horario_parcial').find("input:checked").val()
  #   if horario_parcial == "1"
  #     $('#atendimento_manha').fadeOut(500)
  #     $('#atendimento_tarde').fadeOut(500)
  #   else
  #     $('#atendimento_manha').fadeIn(500)
  #     $('#atendimento_tarde').fadeIn(500)

  discover_week_days = (indice) ->
    if indice == 0
      dia = "Segunda-Feira"
    if indice == 1
      dia = "Terça-Feira"
    if indice == 2
      dia = "Quarta-Feira"
    if indice == 3
      dia = "Quinta-Feira"
    if indice == 4
      dia = "Sexta-Feira"
    if indice == 5
      dia = "Sábado"
    if indice == 6
      dia = "Domingo"
    return dia

  # => Metodo para agrupar os horarios  do turno da Manha informados no formulario da Agenda
  coletor_do_turno_a = () ->
    horarios = []
    i = 0
    while i <= dias_semana
      if $("#agenda_atendimento_manha_inicio_#{i}_attribute").val() == ""
        inicio = ""
      else
        inicio = $("#agenda_atendimento_manha_inicio_#{i}_attribute").val()
      if $("#agenda_atendimento_manha_final_#{i}_attribute").val() == ""
        final = ""
      else
        final  = $("#agenda_atendimento_manha_final_#{i}_attribute").val()

      dia = discover_week_days(i)

      if inicio != "" && final != ""
        horarios.push
          'dia': dia
          'inicio': inicio
          'final':  final
      i++
    return horarios

  # => Metodo para agrupar os horarios  do turno da tarde informados no formulario da Agenda
  coletor_do_turno_b = () ->
    horarios = []
    x =0
    while x <= dias_semana
      inicio = $("#agenda_atendimento_tarde_inicio_#{x}_attribute").val()
      final  = $("#agenda_atendimento_tarde_final_#{x}_attribute").val()

      dia = discover_week_days(x)

      if inicio != "" && final != ""
        horarios.push
          'dia': dia
          'inicio': inicio
          'final':  final
      x++
    return horarios

  verifica_campos = () ->
    x=0
    dia = ""
    error_messages  = []
    agenda_referencia_agenda_id = $("#agenda_referencia_agenda_id :selected").val()
    data_inicial    = $("#agenda_data_inicial").val()
    data_final      = $("#agenda_data_final").val()
    duracao_turno_a = $("#agenda_atendimento_turno_a_duracao").val()
    duracao_turno_b = $("#agenda_atendimento_turno_b_duracao").val()

    if agenda_referencia_agenda_id == ""
      error_messages.push("<li>Referência deve ser selecionado</li>")
    if data_inicial == ""
      error_messages.push("<li>Data Inicial deve ser preenchida</li>")
    if data_final == ""
      error_messages.push("<li>Data Final deve ser preenchida</li>")

    while x <= dias_semana
      if x == 0
        dia="Segunda-Feira"
      if x == 1
        dia="Terça-Feira"
      if x == 2
        dia="Quarta-Feira"
      if x == 3
        dia="Quinta-Feira"
      if x == 4
        dia="Sexta-Feira"
      if x == 5
        dia="Sabado"
      if x == 6
        dia="Domingo"

      if $("#agenda_atendimento_manha_inicio_#{x}_attribute").val() != "" && $("#agenda_atendimento_manha_final_#{x}_attribute").val() != ""
        if $("#agenda_atendimento_turno_a_duracao").val() == ""
          error_messages.push("<li>Os minutos do turno da manhã deve ser preenchido</li>")
        if $("#agenda_atendimento_manha_final_#{x}_attribute").val() <= $("#agenda_atendimento_manha_inicio_#{x}_attribute").val()
          error_messages.push("<li> O horário do #{dia} no turno da manhã, não pode ser inferior nem igual</li>")

      if $("#agenda_atendimento_tarde_inicio_#{x}_attribute").val() != "" && $("#agenda_atendimento_tarde_final_#{x}_attribute").val() != ""
        if $("#agenda_atendimento_turno_b_duracao").val() == ""
          error_messages.push("<li>Os minutos do turno da tarde deve ser preenchido</li>")
        if $("#agenda_atendimento_tarde_final_#{x}_attribute").val() <= $("#agenda_atendimento_tarde_inicio_#{x}_attribute").val()
          error_messages.push("<li> O horário do #{dia} no turno da tarde, não pode ser inferior nem igual</li>")
      x++
    return error_messages

  # => Prepando Ajax Request para enviar dados ao controller/model
  $(".simple_form.new_agenda").submit (event) ->
    event.preventDefault()
    error_messages= []

    error_messages = verifica_campos()

    error_messages = error_messages.filter((value, duplicated) ->
      error_messages.indexOf(value) == duplicated
    )

    if error_messages.length != 0
      $("#error_messages").find(".modal-title").html("Erros Encontrados")
      $("#error_messages").find(".modal-body").html(error_messages)
      $("#error_messages").modal()
    else
      # coletando dados dos horarios
      horarios_turno_a = coletor_do_turno_a()
      horarios_turno_b = coletor_do_turno_b()
      console.log horarios_turno_a
      $.ajax
        url: localhost + "/painel/empresas/#{empresa_id}/agendas"
        type: 'POST'
        dataType: 'JSON'
        timeout: 10000
        data:
          agenda:
            empresa_id:                  empresa_id
            usuario_id:                  $("#agenda_usuario_id").val()
            agenda_referencia_agenda_id: $("#agenda_referencia_agenda_id :selected").val()
            data_inicial:                $("#agenda_data_inicial").val()
            data_final:                  $("#agenda_data_final").val()
            atendimento_sabado:          atendimento_sabado
            atendimento_domingo:         atendimento_domingo
            # atendimento_parcial:         horario_parcial
          horarios:
            turno_a:
              atendimento_duracao: $("#agenda_atendimento_turno_a_duracao").val()
              atendimentos:        horarios_turno_a
              periodo:             "A.M"
            turno_b:
              atendimento_duracao: $("#agenda_atendimento_turno_b_duracao").val()
              atendimentos:        horarios_turno_b
              periodo:             "P.M"
        success: (response) ->
          if response.agenda.completeded == true
            setTimeout (->
              if (response.agenda.flash)
                toastr.info(response.agenda.flash.notice.success, "Aguarde!")
            ), 2000
            setTimeout (->
              $('.progress .progress-bar').progressbar({display_text: 'center', use_percentage: false})
              setTimeout (->
                if (response.agenda.location)
                  window.location.href = localhost + "/painel/empresas/#{empresa_id}/agendas?locale=pt-BR"
              ), 8000
            ), 7000
          else
            setTimeout (->
              if (response.agenda.flash)
                toastr.danger("Um erro não identificado foi detectado. Contate o suporte.", "Essa não :( ")
            ), 2000
            setTimeout (->
              if (response.agenda.location)
                window.location.href = localhost + "/painel/empresas/#{empresa_id}/agendas?locale=pt-BR"
            ), 8000