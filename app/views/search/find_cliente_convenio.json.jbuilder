json.set! :convenio do
  json.extract! @cliente_convenio, :id, :convenio_id, :cliente_id, :matricula, :titular, :plano,
                                    :validade_carteira, :produto, :utilizando_agora, :status_convenio
  json.set! :name, @cliente_convenio.convenio.nome
end
