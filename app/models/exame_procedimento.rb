class ExameProcedimento < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  has_many :grupo_exame_procedimentos
  has_many :grupos, through: :grupo_exame_procedimentos

  validates :descricao, presence: true, uniqueness: true
  validates :tabela, length: { maximum: 2 }
  validates :codigo_procedimento, length: { maximum: 10 }

  RANSACKABLE_ATTRIBUTES = ["descricao", "tabela", "codigo_procedimento"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def title
    "#{descricao} - #{tabela} - #{codigo_procedimento}"
  end

  class << self
    def da_empresa_atual(resource)
      where(empresa_id: resource)
    end
  end
end
