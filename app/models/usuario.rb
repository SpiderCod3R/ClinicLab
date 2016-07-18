class Usuario < ApplicationRecord
  include MetodosUteis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable,
         :registerable, :recoverable,
         :rememberable, :trackable,
         :validatable,:timeoutable

  attr_accessor  :form_steps
  cattr_accessor :form_steps do
    %w(funcionario)
  end

  after_create :upcased_attributes
  before_save :assign_funcao

  belongs_to :empresa
  belongs_to :funcao

  has_many :usuario_permissao_empresas, :dependent => :destroy
  has_many :permissao_empresas, through: :usuario_permissao_empresas

  accepts_nested_attributes_for :usuario_permissao_empresas, allow_destroy: true

  validates_presence_of :nome, :email, :username, :funcao_id
  validates_uniqueness_of :email, :username
  validates :password, presence: false, if: -> { required_for_step?(:funcionario) }

  scope :ordenado_pelo_nome, -> {order(:nome)}
  scope :administradores, -> { joins(:funcao).where( funcoes: { nome: 'ADMINISTRADOR'}) }

  def assign_funcao
    self.funcao = Funcao.find_by nome: "ADMINISTRADOR" if self.funcao.nil?
  end

  def super?
    self.funcao.nome.eql?("SUPER") if funcao.present?
  end

  def admin?
    self.funcao.nome.eql?("ADMINISTRADOR") if funcao.present?
  end

  def funcionario?
    self.funcao.nome.eql?("FUNCIONARIO") if funcao.present?
  end

  def upcased_attributes
    self.nome.upcase!
  end

  def salvar(resource)
    self.save
  end

  def needs_password?
    self.password.present?
  end

  def update_resource(resource)
    if self.needs_password?
      self.update(resource)
    else
      self.update_without_password(resource)
    end
  end

  def update_password(resource)
    update_attributes(password: resource[:password])
  end

  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
end
