class Cliente < ApplicationRecord
  include AtivandoStatus
  before_save :upcased_attributes

  scope :pelo_nome, -> { order("nome ASC") }

  validates :nome, :status, :cpf, :endereco, :bairro,
           :nascimento, :sexo, :rg, :estado_civil, :telefone,
           :status_convenio, :matricula, :plano, :validade_carteira,
           :produto, :titular, presence: true

  validates_associated :cargo, :estado, :cidade, :convenio, :empresa

  usar_como_cpf :cpf

  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo
  belongs_to :convenio

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/

  def upcased_attributes
    self.nome.upcase!
    self.sexo.upcase!
    self.estado_civil.upcase!
    self.bairro.upcase!
  end

  class << self
    def da_empresa(resource)
      where(empresa_id: resource)
    end
  end

  def recupera_agenda_dados(agenda)
    self.nome        = agenda.agenda_movimentacao.nome_paciente
    self.email       = agenda.agenda_movimentacao.email_paciente
    self.telefone    = agenda.agenda_movimentacao.telefone_paciente
    self.convenio_id = agenda.agenda_movimentacao.convenio_id if agenda.agenda_movimentacao.convenio_id?
  end
end
