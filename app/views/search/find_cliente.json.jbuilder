json.set! :convenios do
  if @cliente.cliente_convenios.present?
    json.array!(@cliente.cliente_convenios) do |cliente_convenio|
      json.extract! cliente_convenio, :id, :convenio_id, :cliente_id, :matricula, :titular, :plano,
                                      :validade_carteira, :produto, :utilizando_agora, :status_convenio
      json.set! :convenio do
        json.set! :name, cliente_convenio.convenio.nome
      end
    end
  else
    json.null!
  end
end
