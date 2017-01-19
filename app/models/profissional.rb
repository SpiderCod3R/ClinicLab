class Profissional < ApplicationRecord
  include AtivandoStatus
  include MetodosUteis

  validates :nome, :cargo_id, :data_nascimento,
            :cpf, :rg, :telefone, :celular,
            :operadora_id, :conselho_regional_id,
            :endereco, :bairro,
            :estado_id, :cidade_id, :numero_conselho_regional,
            presence: true

  validates :numero_conselho_regional, length: { maximum: 50 }

  validates_associated :cargo, :estado, :cidade, :operadora

  belongs_to :cargo
  belongs_to :estado
  belongs_to :cidade
  belongs_to :conselho_regional
  belongs_to :operadora
  belongs_to :empresa
  has_many :referencia_agendas
  has_many :agendas, through: :referencia_agendas

  usar_como_cpf :cpf
  scope :pelo_nome, -> {order("nome ASC")}
  scope :da_empresa, -> (empresa_id) { where(empresa_id: empresa_id) }

  has_attached_file :imagem, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\Z/

  delegate :nome,
         to: :cargo,
         prefix: true,
         allow_nil: true

  def titulo
    "#{nome} - #{cargo_nome}"
  end

  def titulo_completo
    "#{id} - #{nome} - #{cargo_nome}"
  end

  def self.search(status, cargo_id, nome) 
    where("status LIKE ? AND cargo_id LIKE ? AND nome LIKE ?", "%#{status}%", "%#{cargo_id}%", "%#{nome}%")
  end
end