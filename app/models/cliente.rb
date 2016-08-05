class Cliente < ApplicationRecord
  scope :pelo_nome, -> { order("nome ASC") }

  validates_presence_of :nome,
            :status, :cpf, :endereco, :bairro,
            :nascimento, :sexo, :rg, :estado_civil, :telefone,
            :status_convenio, :matricula, :plano, :validade_carteira,
            :produto, :titular

  validates_associated :cargo, :estado, :cidade, :convenio, :empresa

  usar_como_cpf :cpf

  before_save :upcased_attributes
  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo
  belongs_to :convenio
  belongs_to :empresa

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/

  def upcased_attributes
    self.nome.upcase!
  end

  class << self
    def da_empresa(resource)
      where(empresa_id: resource)
    end
  end
end