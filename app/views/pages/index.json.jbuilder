json.set! :mes_anterior do
  json.data Time.now.ago(1.month).strftime("%Y-%m-%d")
end

json.set! :mes_atual do
  json.data Time.now.strftime("%Y-%m-%d")
end

json.set! :mes_posterior do
  json.data Time.now.advance(months: 1).strftime("%Y-%m-%d")
end