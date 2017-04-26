#= require JQUERY/jquery.min
#= require dhtmlXSuite/dhtmlx.js

jQuery ->
  URL_BASE = window.location.origin + '/'
  _current_month = ""
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

  load_last_month= (JSONObject)->
    index = 0
    LastMonth = new dhtmlXCalendarObject('calendarOne')
    LastMonth.hideTime()
    LastMonth.show()
    LastMonth.setDate JSONObject.last_month.date
    LastMonth.loadUserLanguage('pt-BR')

    while index <= JSONObject.holidays.length
      if JSONObject.holidays[index] != undefined
        if JSONObject.last_month.month == JSONObject.holidays[index]['month']
          $("#FirstCalendarHolidays").append("<strong><span class='badge'>#{JSONObject.holidays[index]['day']}</span></strong> - <strong style='color: darkred'>#{JSONObject.holidays[index]['name']}</strong><br />")
      index++

  load_current_month= (JSONObject)->
    index = 0
    CurrentMonth = new dhtmlXCalendarObject('calendarTwo')
    CurrentMonth.hideTime()
    CurrentMonth.show()
    CurrentMonth.setDate JSONObject.current_month.date
    CurrentMonth.loadUserLanguage('pt-BR')
    while index <= JSONObject.holidays.length
      if JSONObject.holidays[index] != undefined
        if JSONObject.current_month.month == JSONObject.holidays[index]['month']
          $("#SecondCalendarHolidays").append("<strong><span class='badge'>#{JSONObject.holidays[index]['day']}</span></strong> - <strong style='color: darkred'>#{JSONObject.holidays[index]['name']}</strong><br />")
      index++

  load_after_month= (JSONObject)->
    index = 0
    AfterMonth = new dhtmlXCalendarObject('calendarThre')
    AfterMonth.hideTime()
    AfterMonth.show()
    AfterMonth.setDate JSONObject.after_month.date
    AfterMonth.loadUserLanguage('pt-BR')

    while index <= JSONObject.holidays.length
      if JSONObject.holidays[index] != undefined
        if JSONObject.after_month.month == JSONObject.holidays[index]['month']
          $("#ThirdCalendarHolidays").append("<strong><span class='badge'>#{JSONObject.holidays[index]['day']}</span></strong> - <strong style='color: darkred'>#{JSONObject.holidays[index]['name']}</strong><br />")
      index++

  load_request= ->
    $.ajax
      url: URL_BASE + 'pages/index'
      type: 'GET'
      dataType: 'JSON'
      success: (response) ->
        load_last_month(response)
        load_current_month(response)
        load_after_month(response)
  load_request()