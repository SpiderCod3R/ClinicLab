@last_month   = Time.now.ago(1.month)
@current_month= Time.now
@after_month  = Time.now.advance(months: 1)
@holidays     = Holidays.between(@last_month.beginning_of_month, @after_month.end_of_month, :br, :br, :observed)

json.set! :last_month do
  json.date @last_month.strftime("%Y-%m-%d")
  json.month  Date::MONTHNAMES[@last_month.month]
end

json.set! :current_month do
  json.date @current_month.strftime("%Y-%m-%d")
  json.month  Date::MONTHNAMES[@current_month.month]
end

json.set! :after_month do
  json.date @after_month.strftime("%Y-%m-%d")
  json.month  Date::MONTHNAMES[@after_month.month]
end

json.set! :holidays do
  json.array!(@holidays) do |holiday|
    json.date holiday[:date]
    json.day  holiday[:date].day
    json.month  Date::MONTHNAMES[holiday[:date].month]
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