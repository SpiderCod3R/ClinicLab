require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class Cliente < Connection::Factory
  include ActiveMethods
  include AtivandoStatus

  attr_accessor :receituario, :empresa_name
  attr_accessor :empresa_name, :texto_livres

  scope :pelo_nome, -> { order("nome ASC") }

  validates :nome, :endereco,
            :bairro, :nascimento, :sexo,
            :estado_civil, :telefone, :rg, presence: true


  # validates :cpf, uniqueness: true
  validates :rg, uniqueness: true

  belongs_to :empresa
  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo

  with_options dependent: :destroy do
    has_many :cliente_convenios
    has_many :cliente_pdf_uploads
    has_many :cliente_receituarios
    has_many :cliente_texto_livres
    has_many :historicos
    has_many :imagens_externas
    has_many :sadts
  end

  has_many :convenios, through: :cliente_convenios
  has_many :movimento_servicos

  accepts_nested_attributes_for :cliente_convenios, allow_destroy: true
  accepts_nested_attributes_for :cliente_pdf_uploads, allow_destroy: true
  accepts_nested_attributes_for :historicos, allow_destroy: true
  accepts_nested_attributes_for :imagens_externas, allow_destroy: true
  accepts_nested_attributes_for :sadts, allow_destroy: true

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
    self.save
  end

  def collect_agenda_movimentacao_fields(resource)
    self.indicacao=resource.agenda_movimentacao.indicacao
    self.observacoes=resource.agenda_movimentacao.observacoes
  end

  # => Geranciador de convenios no cliente
  def manage_convenios(resource, option)
    resource ||= JSON.parse(resource.to_json)
    resource.each do |_key, value|

      # binding.pry
      @cliente_convenio = self.cliente_convenios.find_by(id: value["cliente_convenio_id"].to_i) if value["cliente_convenio_id"].present?
      if option="edit" and !@cliente_convenio.nil?
        @cliente_convenio.update_attributes(convenio_id: value["convenio_id"],
                                            status_convenio: value["status_convenio"],
                                            validade_carteira: value["validade_carteira"],
                                            matricula: value["matricula"],
                                            produto: value["produto"],
                                            titular: value["titular"],
                                            plano: value["plano"],
                                            via: value["via"],
                                            observacoes: value["observacoes"],
                                            utilizando_agora: value["utilizando_agora"])
      else
        # binding.pry
        @cliente_convenio = self.cliente_convenios.build(convenio_id: value["convenio_id"].to_i,
                                                        status_convenio: value["status_convenio"],
                                                        validade_carteira: value["validade_carteira"],
                                                        matricula: value["matricula"],
                                                        produto: value["produto"],
                                                        titular: value["titular"],
                                                        plano: value["plano"],
                                                        via: value["via"],
                                                        observacoes: value["observacoes"],
                                                        utilizando_agora: value["utilizando_agora"])
        @cliente_convenio.save!
      end
    end
  end

  def salva_imagens_externas(resource)
    if resource["foto_antes"].present?
      @foto_antes = self.imagens_externas.build(foto_antes: resource["foto_antes"])
      @foto_antes.save!
    end
    if resource["foto_depois"].present?
      @foto_depois= self.imagens_externas.build(foto_depois: resource["foto_depois"])
      @foto_depois.save!
    end
  end
end
