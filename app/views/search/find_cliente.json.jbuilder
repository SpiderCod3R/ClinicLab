json.set! :convenios do
  if @cliente.cliente_convenios.present?
    json.array!(@cliente.cliente_convenios) do |cliente_convenio|
      json.extract! cliente_convenio, :id, :convenio_id, :cliente_id, :matricula, :titular, :plano,
                                      :produto, :utilizando_agora, :status_convenio
      json.set! :data_carteira, cliente_convenio.validade_carteira.strftime("%d/%m/%Y") if cliente_convenio.validade_carteira?
      json.set! :convenio do
        json.set! :name, cliente_convenio.convenio.nome
      end
    end
  else
    json.null!
  end
end
