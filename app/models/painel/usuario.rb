class Painel::Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:timeoutable

  belongs_to :empresa

  validates :nome, :login, :email, presence: true

  # validates :password, presence: true
  # validates :password_confirmation, presence: { message: "Confirmação de Senha - a senha precisa ser igual à informada." }

  delegate :nome,
           to: :empresa,
           prefix: true,
           allow_nil: true

  '''
    Methods
  '''

  def password_filled_in?
    return unless password.blank?
  end

  def update_with_password(resource)
    update(resource)
  end
end
