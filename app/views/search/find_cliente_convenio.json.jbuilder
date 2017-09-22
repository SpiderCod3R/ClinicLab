json.set! :convenio do
  json.extract! @cliente_convenio, :id, :convenio_id, :cliente_id, :matricula, :titular, :plano,
                                   :produto, :utilizando_agora, :status_convenio
  json.set! :name, @cliente_convenio.convenio.nome
  if @cliente_convenio.validade_carteira.present?
    json.set! :data_carteira, @cliente_convenio.validade_carteira.strftime("%d/%m/%Y")
  else
    json.set! :data_carteira, nil
  end
end
