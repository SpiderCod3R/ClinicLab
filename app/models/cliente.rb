class Cliente < ApplicationRecord
  before_save :upcased_attributes

  scope :pelo_nome, -> { order("nome ASC") }

  validates_presence_of :nome, :cpf, :endereco, :bairro,
            :nascimento, :sexo, :rg, :estado_civil, :telefone,
            :status_convenio, :matricula, :plano, :validade_carteira,
            :produto, :titular

  validates_associated :cargo, :estado, :cidade, :convenio

  usar_como_cpf :cpf

  before_create :set_status_cliente
  before_save :upcased_attributes

  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo
  belongs_to :convenio
  belongs_to :empresa
  has_many :historicos

  accepts_nested_attributes_for :historicos, allow_destroy: true

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/

  def set_status_cliente
    self.status = 'Ativo'
  end

  def upcased_attributes
    self.nome.upcase!
    self.bairro.upcase!
  end

  class << self
    def da_empresa(resource)
      where(empresa_id: resource)
    end
  end
end
