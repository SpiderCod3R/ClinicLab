class Empresa < Connection::Factory
  include ActiveMethods
  extend FriendlyId

  friendly_id :nome, use: :slugged

  validates :nome, presence: true
  validates :nome, uniqueness: true

  # => Opções com reação em Cadeia apos o destroy da empresa
  with_options dependent: :destroy do
    has_many :agendas
    has_many :atendimentos
    has_many :cargos
    has_many :convenios
    has_many :clientes
    has_many :centro_de_custos
    has_one  :configuracao_relatorio
    has_many :operadoras
    has_many :profissionais
    has_many :users, class_name: "Gclinic::User"
  end

  accepts_nested_attributes_for :users,
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

  def admins
    users.where(admin: true)
  end

  def employees
    users.where(admin: false)
  end
end
