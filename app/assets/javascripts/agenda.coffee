$(document).ready ->
  i = 0
  dias_semana = 6
  atendimento_sabado   =$("#atendimento_sabado").find("input:checked").val()
  atendimento_domingo  =$("#atendimento_sabado").find("input:checked").val()
  horario_parcial      =$("#horario_parcial").find("input:checked").val()
  empresa_id = $("#agenda_empresa_id").val()
  localhost = window.location.origin

  horarios_manha = []
  horarios_tarde = []

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

  $('#horario_parcial').change ->
    horario_parcial = $('#horario_parcial').find("input:checked").val()
    if horario_parcial == "1"
      $('#atendimento_manha').fadeOut(500)
      $('#atendimento_tarde').fadeOut(500)
    else
      $('#atendimento_manha').fadeIn(500)
      $('#atendimento_tarde').fadeIn(500)

  coletor_do_turno_da_manha = () ->
    while i <= dias_semana
      inicio = $("#agenda_atendimento_manha_inicio_#{i}_attribute").val()
      final  = $("#agenda_atendimento_manha_final_#{i}_attribute").val()

      if inicio != "" && final != ""
        horarios_manha.push
          'inicio': inicio
          'final':  final
      i++

  $(".simple_form.new_agenda").submit (event) ->
    event.preventDefault()
    # coletando dados dos horarios
    coletor_do_turno_da_manha()

    # preparando e enviando informaçõe para o controller
    $.ajax
      url: localhost + "/painel/empresas/#{empresa_id}/agendas"
      type: 'POST'
      dataType: 'JSON'
      timeout: 10000
      data:
        agenda:
          empresa_id:          empresa_id
          profissional_id:     $("#agenda_profissional_id :selected").val()
          data_inicial:        $("#agenda_data_inicial").val()
          data_final:          $("#agenda_data_final").val()
          atendimento_manha_duracao:     $("#agenda_atendimento_manha_duracao").val()
          atendimento_sabado:  atendimento_sabado
          atendimento_domingo: atendimento_domingo
          atendimento_parcial: horario_parcial
          horarios_manha:      horarios_manha
      success: (data) ->
        console.log data
        if data.agenda.successfully_created == true
          setTimeout (->
            if (data.agenda.flash)
              toastr.success(data.agenda.flash.notice.success, "Sucesso.", {timeOut: 3000})
          ), 2000
          setTimeout (->
            if (data.agenda.location)
              window.location.href = localhost + "/painel/empresas/#{empresa_id}/agendas?locale=pt-BR"
          ), 5000