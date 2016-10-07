class Profissional < ApplicationRecord
  include MetodosUteis

  validates :nome, :cargo_id, :data_nascimento,
            :cpf, :rg, :telefone, :celular,
            :operadora_id, :conselho_regional_id,
            :endereco, :complemento, :bairro,
            :estado_id, :cidade_id,  presence: true

  validates_associated :cargo, :estado, :cidade, :operadora

  belongs_to :cargo
  belongs_to :estado
  belongs_to :cidade
  belongs_to :conselho_regional
  belongs_to :operadora
  belongs_to :empresa

  usar_como_cpf :cpf
  scope :pelo_nome, -> {order("nome ASC")}

  has_attached_file :imagem, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\Z/

  delegate :nome,
         to: :cargo,
         prefix: true,
         allow_nil: true

  def titulo
    "#{nome} - #{cargo_nome}"
  end
end
