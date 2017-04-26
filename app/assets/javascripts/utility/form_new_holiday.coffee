#= require JQUERY/jquery.min
#= require dhtmlXSuite/dhtmlx.js

jQuery ->
  URL_BASE = window.location.origin + '/'
  _object_month = ""
  month = $("#feriado_e_data_comemorativa_data_2i").val()
  day   = $("#feriado_e_data_comemorativa_data_3i").val()
  year  = $("#feriado_e_data_comemorativa_data_1i").val()
  dhtmlXCalendarObject::langData['pt-BR'] =
    dateformat: '%d.%m.%Y'
    monthesFNames: [
      'Janeiro'
      'Fevereiro'
      'Março'
      'Abril'
      'Maio'
      'Junho'
      'Julho'
      'Agosto'
      'Setembro'
      'Outubro'
      'Novembro'
      'Dezembro'
    ]
    monthesSNames: [
      'Jan'
      'Feb'
      'Maç'
      'Abr'
      'Mai'
      'Jun'
      'Jul'
      'Ago'
      'Set'
      'Out'
      'Nov'
      'Dez'
    ]
    daysFNames: [
      'Domingo'
      'Segunda'
      'Terça'
      'Quarta'
      'Quinta'
      'Sexta'
      'Sabado'
    ]
    daysSNames: [
      'Do'
      'Se'
      'Te'
      'Qua'
      'Qui'
      'Sex'
      'Sa'
    ]
    weekstart: 7

  load_month= ->
    index = 0
    Month = new dhtmlXCalendarObject('calendarDHTMLX')
    Month.hideTime()
    Month.show()
    Month.loadUserLanguage('pt-BR')
    return Month

  _object_month = load_month()

  $("#feriado_e_data_comemorativa_data_2i").change ->
    month = $("#feriado_e_data_comemorativa_data_2i").val()
    load_month_date("#{year}-#{month}-#{day}")
  $("#feriado_e_data_comemorativa_data_3i").change ->
    day = $("#feriado_e_data_comemorativa_data_3i").val()
    load_month_date("#{year}-#{month}-#{day}")
  $("#feriado_e_data_comemorativa_data_1i").change ->
    year = $("#feriado_e_data_comemorativa_data_1i").val()
    load_month_date("#{year}-#{month}-#{day}")

  load_month_date= (american_date_format) ->
    console.log "Hey"
    _object_month.setDate american_date_format
    _object_month.show()