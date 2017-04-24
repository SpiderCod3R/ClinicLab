@mes_anterior = Time.now.ago(1.month).strftime("%Y-%m-%d")
@mes_atual    = Time.now.strftime("%Y-%m-%d")
@mes_posterior= Time.now.advance(months: 1).strftime("%Y-%m-%d")
@feriados     = Holidays.between(@mes_anterior, @mes_posterior, :br, :br, :observed)

json.set! :mes_anterior do
  json.data @mes_anterior
end

json.set! :mes_atual do
  json.data @mes_atual
end

json.set! :mes_posterior do
  json.data @mes_posterior
end

json.set! :feriados do
  json.array!(@feriados) do |feriado|
    json.data feriado[:date]
    json.dia  Date::DAYNAMES[feriado[:date].wday]
    json.mes  Date::MONTHNAMES[feriado[:date].month]
    json.ano  feriado[:date].year
    json.nome feriado[:name]
  end
end