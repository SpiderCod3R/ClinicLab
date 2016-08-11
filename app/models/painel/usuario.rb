#-*- coding: utf-8 -*-
class Painel::Usuario < ApplicationRecord
  '''
    Virtual attributes for Painel::UsuarioPermissao
    -> has_many :usuario_permissoes
  '''
  attr_accessor :permissao_id, :cadastrar, :atualizar, :deletar, :exibir
  attr_writer   :permissao_id, :cadastrar, :atualizar, :deletar, :exibir

  '''
    Devise scope
  '''
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable,:timeoutable
         # :lockable

  '''
    Associations
  '''
  belongs_to :empresa
  has_many :usuario_permissoes, dependent: :destroy

  '''
    Validations
  '''
  validates :nome, :login, :email, presence: true

  '''
    Delegate methods
  '''
  delegate :nome,
           to: :empresa,
           prefix: true,
           allow_nil: true

  '''
    Class Methods
  '''

  class << self
    def new_by(resoure_params)
      new(login: resoure_params[:login], nome: resoure_params[:nome], email: resoure_params[:email], password: resoure_params[:password],
              admin: resoure_params[:admin], codigo_pais: resoure_params[:codigo_pais], telefone: resoure_params[:telefone])
    end
  end

  '''
    Methods
  '''

  def password_filled_in?
    return unless password.blank?
  end

  def update_with_password(resource)
    update(resource)
  end

  def import_permissoes(resoure_array)
    resoure_array.each do |_key, single|
      usuario_permissoes.build(permissao_id: single[:permissao_id].to_i, cadastrar: single[:cadastrar].to_b,
                               atualizar: single[:atualizar].to_b, exibir: single[:exibir].to_b, deletar: single[:deletar].to_b)
    end
  end
end
