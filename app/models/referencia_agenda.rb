class ReferenciaAgenda < ApplicationRecord
  include AtivandoStatus
  belongs_to :profissional
  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  has_many :agendas
  paginates_per 10

  validates :profissional_id, :descricao, presence: true


  def self.localize(id, empresa)
    find_by(id: id, empresa_id: empresa.id)
  end

  def ultima_atualizacao
    return if agendas.empty?
    agendas.last.status != I18n.t("agendas.helpers.free")
  end

  def descricao_completa
    "#{id} - #{descricao}"
  end

  delegate :id, :nome,
           to: :profissional,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :empresa,
           prefix: true,
           allow_nil: true
end
