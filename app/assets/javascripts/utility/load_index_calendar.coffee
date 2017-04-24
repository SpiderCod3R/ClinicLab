#= require JQUERY/jquery.min
#= require dhtmlXSuite/dhtmlx.js

URL_BASE = window.location.origin + '/'
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
  # weekname: 'w'
  # today: 'Hoje'
  # clear: 'limpar'

jQuery ->
  $.ajax
    url: URL_BASE + 'pages/index'
    type: 'GET'
    dataType: 'JSON'
    success: (response) ->
      FirstCalendar = new dhtmlXCalendarObject('calendarOne')
      SecondCalendar = new dhtmlXCalendarObject('calendarTwo')
      ThirdCalendar = new dhtmlXCalendarObject('calendarThre')
      FirstCalendar.hideTime()
      SecondCalendar.hideTime()
      ThirdCalendar.hideTime()
      FirstCalendar.show()
      SecondCalendar.show()
      ThirdCalendar.show()
      FirstCalendar.setDate response.mes_anterior.data
      SecondCalendar.setDate response.mes_atual.data
      SecondCalendar.setDate response.mes_atual.data
      ThirdCalendar.setDate response.mes_posterior.data

      FirstCalendar.loadUserLanguage('pt-BR');
      SecondCalendar.loadUserLanguage('pt-BR');
      ThirdCalendar.loadUserLanguage('pt-BR');