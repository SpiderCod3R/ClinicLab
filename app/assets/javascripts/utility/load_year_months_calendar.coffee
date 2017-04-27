#= require JQUERY/jquery.min
#= require dhtmlXSuite/dhtmlx.js
#= require utility/DHTMLXCalendar/pt-BR

jQuery ->
  localhost = window.location.origin
  empresa_id = $("#empresa_id").text()
  counter = 1
  index   = 0

  load_month=(year, month, month_name, holidays, celebration_dates) ->
    calendar = new dhtmlXCalendarObject(month_name)
    calendar.hideTime()
    calendar.hideToday()
    calendar.show()
    if month < 10
      month = "0#{month}"
    calendar.setDate("#{year}-#{month}-01")
    calendar.loadUserLanguage('pt-BR')
    load_holiday(holidays, month_name)
    load_celebration_dates(celebration_dates, month_name)

  load_holiday=(holidays, month_name) ->
    c = 0
    while c <= holidays.length
      if holidays[c] != undefined && holidays[c].month_name == month_name
       $("##{month_name}Feriados").append("<strong><span class='badge'>#{holidays[c].day}</span></strong> - <strong style='color: darkred'>#{holidays[c].name}</strong><br />")
      c++

  load_celebration_dates=(dates, month_name) ->
    c = 0
    while c <= dates.length
      if dates[c] != undefined && dates[c].month_name == month_name
       $("##{month_name}Feriados").append("<strong><span class='badge'>#{dates[c].day}</span></strong> - <strong style='color: #2F4F4F'>#{dates[c].name}</strong><br />")
      c++

  load_request= ->
    $.ajax
      url: localhost + "/empresa/#{empresa_id}/feriado_e_data_comemorativas"
      type: 'GET'
      dataType: 'JSON'
      success: (response) ->
        while index <= response.year_months.length
          if response.year_months[index]!= undefined
            while counter <= 12
              load_month(response.year, counter, response.year_months[index]["name"], response.year_holidays, response.celebration_dates)
              counter++
              break
          index++

  if $(".load_year_calendar").length
    load_request()