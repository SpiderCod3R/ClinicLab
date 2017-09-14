class ExameProcedimento < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  validates_presence_of :descricao, :tabela, :codigo_procedimento
  validates :tabela, length: { maximum: 2 }
  validates :codigo_procedimento, length: { maximum: 10 }

  RANSACKABLE_ATTRIBUTES = ["descricao", "tabela", "codigo_procedimento"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  class << self
    def da_empresa_atual(resource)
      where(empresa_id: resource)
    end
  end
end
