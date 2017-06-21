#= require JQUERY/jquery.min
#= require dhtmlXSuite/dhtmlx.js
#= require utility/DHTMLXCalendar/pt-BR
jQuery ->
  URL_BASE = window.location.origin + '/'

  load_celebration_dates=(celebration_dates, month_name) ->
    c = 0
    while c <= celebration_dates.length
      if celebration_dates[c] != undefined && celebration_dates[c].month_name == month_name
       $("##{month_name}Feriados").append("<strong><span class='badge'>#{celebration_dates[c].day}</span></strong> - <strong style='color: #2F4F4F'>#{dates[c].name}</strong><br />")
      c++

  load_last_month= (JSONObject)->
    index = 0
    c = 1
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
    while c <= JSONObject.celebration_dates.length
      if JSONObject.celebration_dates[c] != undefined && JSONObject.celebration_dates[c].month_name == JSONObject.last_month.month
       $("#FirstCalendarHolidays").prepend("<strong><span class='badge'>#{JSONObject.celebration_dates[c].day}</span></strong> - <strong style='color: #2F4F4F'>#{JSONObject.celebration_dates[c].name}</strong><br />")
      c++

  load_current_month= (JSONObject)->
    index = 0
    c=0
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
    while c <= JSONObject.celebration_dates.length
      if JSONObject.celebration_dates[c] != undefined && JSONObject.celebration_dates[c].month_name == JSONObject.current_month.month
       $("#SecondCalendarHolidays").append("<strong><span class='badge'>#{JSONObject.celebration_dates[c].day}</span></strong> - <strong style='color: #2F4F4F'>#{JSONObject.celebration_dates[c].name}</strong><br />")
      c++

  load_after_month= (JSONObject)->
    index = 0
    c=0
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
    while c <= JSONObject.celebration_dates.length
      if JSONObject.celebration_dates[c] != undefined && JSONObject.celebration_dates[c].month_name == JSONObject.after_month.month
       $("#ThirdCalendarHolidays").append("<strong><span class='badge'>#{JSONObject.celebration_dates[c].day}</span></strong> - <strong style='color: #2F4F4F'>#{JSONObject.celebration_dates[c].name}</strong><br />")
      c++

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
