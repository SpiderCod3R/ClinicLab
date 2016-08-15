#-*-coding:utf-8-*-
class Painel::Empresa < ApplicationRecord
  validates :nome, presence: true
  validates :nome, uniqueness: true

  # => Opções com reação em Cadeia apos o destroy da empresa
  with_options dependent: :destroy do
    has_many :atendimentos
    has_many :cargos
    has_many :convenios
    has_many :clientes
    has_many :centro_de_custos
    has_one  :configuracao_relatorio
    has_many :operadoras
    has_many :pacientes
    has_many :profissionais
    has_many :pacientes
    has_many :usuarios
    has_many :empresa_permissoes
  end

  has_many :permissoes, through: :empresa_permissoes

  scope :em_ordem_alfabetica, -> { order('nome ASC') }

  accepts_nested_attributes_for :usuarios,
                                reject_if: proc { |attributes| attributes['email'].blank?},
                                allow_destroy: true

  def possui_todas_as_permissoes?
    Painel::Permissao.all.each do |permissao|
      empresa_permissoes.each do |empresa_permissao|
        until empresa_permissao.permissao != permissao
          return false
        end
      end
    end
    return true
  end

  def is_on?
    self.status ? true : false
  end

  def administradores
    usuarios.where(admin: true)
  end

  def funcionarios
    usuarios.where(admin: false)
  end

  def import_todas_permissoes
    Painel::Permissao.all.each do |permissao|
      self.empresa_permissoes.build(permissao_id: permissao.id)
    end
    self.save
  end

  def import_permissoes(resource)
    resource[:permissao_ids].delete("")
    resource[:permissao_ids].each do |id|
      self.empresa_permissoes.build(permissao_id: id)
    end
    self.save!
  end
end
