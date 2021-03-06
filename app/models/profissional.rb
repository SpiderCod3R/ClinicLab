class Profissional < Connection::Factory
  include ActiveMethods
  include AtivandoStatus

  validates :nome, :cargo_id, :data_nascimento,
            :cpf, :rg, :telefone, :celular,
            :operadora_id, :conselho_regional_id,
            :endereco, :bairro,
            :estado_id, :cidade_id, :numero_conselho_regional,
            presence: true

  validates :numero_conselho_regional, length: { maximum: 50 }

  belongs_to :cargo
  belongs_to :estado
  belongs_to :cidade
  belongs_to :conselho_regional
  belongs_to :operadora
  belongs_to :empresa
  has_many :referencia_agendas
  has_many :agendas, through: :referencia_agendas

  validates :nome, :cargo_id, :data_nascimento,
            :cpf, :rg, :telefone, :celular,
            :operadora_id, :conselho_regional_id,
            :endereco, :bairro,
            :estado_id, :cidade_id, :numero_conselho_regional,
            presence: true

  validates :numero_conselho_regional, length: { maximum: 50 }

  usar_como_cpf :cpf
  scope :pelo_nome, -> {order("nome ASC")}
  scope :da_empresa, -> (empresa_id) { where(empresa_id: empresa_id) }

  has_attached_file :imagem, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\Z/

  delegate :nome,
         to: :cargo,
         prefix: true,
         allow_nil: true

  paginates_per 10

  def titulo_resumido
    "#{id} - #{nome}"
  end

  def titulo
    "#{nome} - #{cargo_nome}"
  end

  def titulo_completo
    "#{id} - #{nome} - #{cargo_nome}"
  end

  def self.search(status, cargo_id, nome) 
    where("status LIKE ? AND cargo_id LIKE ? AND nome LIKE ?", "%#{status}%", "%#{cargo_id}%", "%#{nome}%")
  end

  def self.cargo_medico
    @cargo = Cargo.find_by(nome: 'Médico')
    self.where(cargo_id: @cargo.id).order(:nome)
  end
end