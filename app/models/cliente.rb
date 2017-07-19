require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class Cliente < Connection::Factory
  include ActiveMethods
  include AtivandoStatus

  attr_accessor :empresa_name, :texto_livres

  scope :pelo_nome, -> { order("nome ASC") }

  validates :nome, :endereco,
            :bairro, :nascimento, :sexo,
            :estado_civil, :telefone, presence: true

  attr_accessor :receituario, :empresa_name

  validates :cpf, cpf: true, presence: true, uniqueness: true
  validates :rg, uniqueness: true, presence: true

  belongs_to :empresa
  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo

  with_options dependent: :destroy do
    has_many :historicos
    has_many :cliente_texto_livres
    has_many :cliente_pdf_uploads
    has_many :imagens_externas
    has_many :cliente_texto_livres
    has_many :cliente_pdf_uploads
    has_many :cliente_convenios
    has_many :cliente_receituarios
  end

  has_many :convenios, through: :cliente_convenios
  has_many :movimento_servicos

  accepts_nested_attributes_for :cliente_convenios, allow_destroy: true
  accepts_nested_attributes_for :historicos, allow_destroy: true
  accepts_nested_attributes_for :imagens_externas, allow_destroy: true
  accepts_nested_attributes_for :cliente_pdf_uploads, allow_destroy: true

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/

  RANSACKABLE_ATTRIBUTES = ["status","nome","cpf"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  class << self
    def da_empresa(resource)
      where(empresa: resource)
    end
  end

  def recupera_agenda_dados(agenda)
    self.nome        = agenda.agenda_movimentacao.nome_paciente
    self.email       = agenda.agenda_movimentacao.email_paciente
    self.telefone    = agenda.agenda_movimentacao.telefone_paciente
    self.convenio_id = agenda.agenda_movimentacao.convenio_id if agenda.agenda_movimentacao.convenio_id?
  end

  def update_data(resource)
    update_attributes(status:       resource[:status],
                      nome:         resource[:nome],
                      nascimento:   resource[:nascimento],
                      sexo:         resource[:sexo],
                      estado_civil: resource[:estado_civil],
                      cpf:          resource[:cpf],
                      rg:           resource[:rg],
                      email:   resource[:email],
                      telefone: resource[:telefone],
                      endereco: resource[:endereco],
                      complemento: resource[:complemento],
                      bairro:      resource[:bairro],
                      estado_id:   resource[:estado_id],
                      cargo_id:    resource[:cargo_id])
  end

  def upload_files(resource)
    self.cliente_pdf_uploads.build(data: Date.today,anotacoes: resource[:anotacoes], pdf: resource[:pdf])
  end

  def collect_agenda_movimentacao_fields(resource)
    self.indicacao=resource.agenda_movimentacao.indicacao
    self.observacoes=resource.agenda_movimentacao.observacoes
  end

  def manage_convenios(resource_attributes)
    resource ||= JSON.parse(resource_attributes.to_json)
    resource.each do |_key, value|
      @cliente_convenio = self.cliente_convenios.find(value["cliente_convenio_id"]) if value["cliente_convenio_id"].present?
      if !@cliente_convenio.nil?
        @cliente_convenio.update_attributes(convenio_id: value["convenio_id"],
                                                        status_convenio: value["status_convenio"],
                                                        validade_carteira: value["validade_carteira"],
                                                        matricula: value["matricula"],
                                                        produto: value["produto"],
                                                        titular: value["titular"],
                                                        plano: value["plano"],
                                                        utilizando_agora: value["utilizando_agora"])
      else
        @cliente_convenio = self.cliente_convenios.build(convenio_id: value["convenio_id"],
                                                        status_convenio: value["status_convenio"],
                                                        validade_carteira: value["validade_carteira"],
                                                        matricula: value["matricula"],
                                                        produto: value["produto"],
                                                        titular: value["titular"],
                                                        plano: value["plano"],
                                                        utilizando_agora: value["utilizando_agora"])
        @cliente_convenio.save!
      end
    end
  end
end
