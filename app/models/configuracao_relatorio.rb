class ConfiguracaoRelatorio < ApplicationRecord
  include MetodosUteis
  include Paperclip::Glue
  
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/


  belongs_to :empresa
  validates :nome_empresa, :cnpj, :telefone, :endereco,
            :bairro, :cidade_estado, :email, presence: true
  after_create :upcased_attributes

  def nome
    nome_empresa
  end

  def to_s
    "#{nome_empresa} - #{cnpj}"
  end

  def upcased_attributes
    self.nome_empresa.upcase!
  end
end
