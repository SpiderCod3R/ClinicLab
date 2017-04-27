#= require JQUERY/jquery.min
#= require dhtmlXSuite/dhtmlx.js

jQuery ->
  URL_BASE = window.location.origin + '/'
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
    Month = new dhtmlXCalendarObject('calendarDHTMLX')
    Month.hideTime()
    Month.show()
    Month.loadUserLanguage('pt-BR')

  load_month()

  load_month_date= (year, month, day) ->
    $("#calendarDHTMLX").empty()
    newDate = new dhtmlXCalendarObject('calendarDHTMLX')
    newDate.hideTime()
    if month < 10
      month = "0#{month}"
    if day < 10
      day = "0#{day}"
    newDate.setDate("#{year}-#{month}-#{day}")
    newDate.loadUserLanguage('pt-BR')
    newDate.show()

  preview_holiday=(day, description) ->
    $("#PreviewHolidays").html("<strong><span class='badge'>#{day}</span></strong> - <strong style='color: #2F4F4F'>#{description}</strong><br />")

  $("#feriado_e_data_comemorativa_data_2i").change ->
    month = $(this).val()
    load_month_date(year, month, day)
    preview_holiday(day, $("#feriado_e_data_comemorativa_descricao").val())
  $("#feriado_e_data_comemorativa_data_3i").change ->
    day = $(this).val()
    load_month_date(year, month, day)
    preview_holiday(day, $("#feriado_e_data_comemorativa_descricao").val())
  $("#feriado_e_data_comemorativa_data_1i").change ->
    year = $(this).val()
    load_month_date(year, month, day)
    preview_holiday(day, $("#feriado_e_data_comemorativa_descricao").val())
  $("#feriado_e_data_comemorativa_descricao").blur ->
    preview_holiday(day, $("#feriado_e_data_comemorativa_descricao").val())