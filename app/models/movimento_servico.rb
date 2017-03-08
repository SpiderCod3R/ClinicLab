class MovimentoServico < Connection::Factory
  include ActiveMethods

  belongs_to :cliente
  belongs_to :convenio
  belongs_to :atendente, class_name: "Gclinic::User", foreign_key: :atendente_id
  belongs_to :atualizador, class_name: "Gclinic::User", foreign_key: :atualizador_id
  belongs_to :solicitante, class_name: "Profissional", foreign_key: :solicitante_id
  belongs_to :medico, class_name: "Profissional", foreign_key: :medico_id
  belongs_to :empresa
  has_many :movimento_servico_servicos, dependent: :destroy
  has_many :servicos, through: :movimento_servico_servicos

  accepts_nested_attributes_for :movimento_servico_servicos, allow_destroy: true

  usar_como_dinheiro :valor_total, :valor_desconto
end
