class MovimentoServicoServico < Connection::Factory
  include ActiveMethods

  belongs_to :movimento_servico
  belongs_to :servico
end
