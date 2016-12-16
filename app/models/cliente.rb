require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class Cliente < ApplicationRecord
  include AtivandoStatus
  before_save :upcased_attributes

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
  has_many :cliente_texto_livres
  has_many :cliente_pdf_uploads

  accepts_nested_attributes_for :historicos, allow_destroy: true
  accepts_nested_attributes_for :cliente_pdf_uploads, reject_if: :all_blank, allow_destroy: true

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/


  def upcased_attributes
    self.nome.upcase!
    self.sexo.upcase!
    self.estado_civil.upcase!
    self.bairro.upcase!
  end

  class << self
    def da_empresa(resource)
      where(empresa_id: resource)
    end
  end

  def recupera_agenda_dados(agenda)
    self.nome        = agenda.agenda_movimentacao.nome_paciente
    self.email       = agenda.agenda_movimentacao.email_paciente
    self.telefone    = agenda.agenda_movimentacao.telefone_paciente
    self.convenio_id = agenda.agenda_movimentacao.convenio_id if agenda.agenda_movimentacao.convenio_id?
  end

  def update_data(resource)
    nascimento = Converter::DateConverter.new(resource["nascimento(1i)"].to_i, resource["nascimento(2i)"].to_i, resource["nascimento(3i)"].to_i)
    validade_carteira = Converter::DateConverter.new(resource["validade_carteira(1i)"].to_i, resource["validade_carteira(2i)"].to_i, resource["validade_carteira(3i)"].to_i)
    update_attributes(status:       resource[:status],
                      nome:         resource[:nome],
                      nascimento:   nascimento.to_american_format,
                      sexo:         resource[:sexo],
                      estado_civil: resource[:estado_civil],
                      cpf:          resource[:cpf],
                      rg:           resource[:rg],
                      status_convenio: resource[:status_convenio],
                      matricula:       resource[:matricula],
                      convenio_id:     resource[:convenio_id],
                      validade_carteira: validade_carteira.to_american_format,
                      produto: resource[:produto],
                      titular: resource[:titular],
                      plano:   resource[:plano],
                      email:   resource[:email],
                      telefone: resource[:telefone],
                      endereco: resource[:endereco],
                      complemento: resource[:complemento],
                      bairro:      resource[:bairro],
                      estado_id:   resource[:estado_id],
                      cargo_id:    resource[:cargo_id])
  end

  def upload_files(resource)
    data = Converter::DateConverter.new(resource["data(1i)"].to_i, resource["data(2i)"].to_i, resource["data(3i)"].to_i)
    self.cliente_pdf_uploads.build(data: data.to_american_format,
                                   anotacoes: resource[:anotacoes],
                                   pdf: resource[:pdf]
                                  )
    self.save
  end
end
