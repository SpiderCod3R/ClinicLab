class AgendaMovimentacao < ApplicationRecord
  belongs_to :agenda
  belongs_to :convenio
  belongs_to :cliente

  delegate :nome,
           to: :convenio,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :cliente,
           prefix: true,
           allow_nil: true

  validates :agenda_id, :convenio_id, :cliente_id, presence: true
  validates_associated :agenda, :convenio, :cliente

  accepts_nested_attributes_for :cliente,
                                reject_if: proc { |attributes| attributes['nome', 'telefone', 'email'].blank?},
                                allow_destroy: true
end
