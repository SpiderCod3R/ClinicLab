class ConfiguracaoRelatorio < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  validates :nome_empresa, :cnpj, :telefone, :endereco,
            :bairro, :cidade_estado, :email, presence: true
  after_create :upcased_attributes

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def to_s
    "#{empresa.nome} - #{cnpj}"
  end

  def upcased_attributes
    self.nome_empresa.upcase!
  end
end
