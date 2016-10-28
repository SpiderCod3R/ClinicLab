class Cliente < ApplicationRecord
  scope :pelo_nome, -> { order("nome ASC") }

  validates_presence_of :nome, :cpf, :endereco, :bairro,
            :nascimento, :sexo, :rg, :estado_civil, :telefone,
            :status_convenio, :matricula, :plano, :validade_carteira,
            :produto, :titular

  validates_associated :cargo, :estado, :cidade, :convenio

  usar_como_cpf :cpf

  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo
  belongs_to :convenio
  has_many :historicos
  accepts_nested_attributes_for :historicos, allow_destroy: true

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/
end
