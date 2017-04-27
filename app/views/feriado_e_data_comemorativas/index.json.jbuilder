@yearHolidays = Holidays.year_holidays([:pt], Date.civil(Time.now.year, 1, 1))

json.year Time.now.year

json.set! :year_months do
  json.array! Date::MONTHNAMES do |month|
    if !month.nil?
      json.name month
    end
  end
end

json.set! :year_holidays do
  json.array!(@yearHolidays) do |holiday|
    json.date holiday[:date]
    json.day  holiday[:date].day
    json.month_name   Date::MONTHNAMES[holiday[:date].month]
    json.month_number holiday[:date].month
    json.year  holiday[:date].year
    json.name holiday[:name]
  end
end

json.set! :celebration_dates do
  json.array!(@feriado_e_data_comemorativas) do |holiday|
    json.date  holiday.data
    json.day   holiday.data.day
    json.month_name   Date::MONTHNAMES[holiday.data.month]
    json.month_number holiday.data.month
    json.year  holiday.data.year
    json.name  holiday.descricao
  end
end