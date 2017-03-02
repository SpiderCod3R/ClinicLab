require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class Cliente < ApplicationRecord
  include AtivandoStatus

  scope :pelo_nome, -> { order("nome ASC") }

  validates_presence_of :nome, :cpf, :endereco, :bairro,
            :nascimento, :sexo, :rg, :estado_civil, :telefone

  validates_associated :cargo, :estado, :cidade

  usar_como_cpf :cpf

  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo
  has_many :historicos
  has_many :imagens_externas
  has_many :cliente_texto_livres
  has_many :cliente_pdf_uploads
  has_many :cliente_convenios, dependent: :destroy
  has_many :convenios, through: :cliente_convenios
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
    update_attributes(status:       resource[:status],
                      nome:         resource[:nome],
                      nascimento:   resource[:nascimento],
                      sexo:         resource[:sexo],
                      estado_civil: resource[:estado_civil],
                      cpf:          resource[:cpf],
                      rg:           resource[:rg],
                      # status_convenio: resource[:status_convenio],
                      # matricula:       resource[:matricula],
                      # convenio_id:     resource[:convenio_id],
                      # validade_carteira: resource[:validade_carteira],
                      # produto: resource[:produto],
                      # titular: resource[:titular],
                      # plano:   resource[:plano],
                      email:   resource[:email],
                      telefone: resource[:telefone],
                      endereco: resource[:endereco],
                      complemento: resource[:complemento],
                      bairro:      resource[:bairro],
                      estado_id:   resource[:estado_id],
                      cargo_id:    resource[:cargo_id])
  end

  def upload_files(resource)
    self.cliente_pdf_uploads.build(data: Date.today,
                                   anotacoes: resource[:anotacoes],
                                   pdf: resource[:pdf]
                                  )
    # # binding.pry
    # if self.cliente_pdf_uploads.last.valid?
    #   self.save
    #   return true
    # else
    #   return false
    # end
  end
end
