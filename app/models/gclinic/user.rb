class Gclinic::User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :environment, class_name: "Gclinic::Environment"
  belongs_to :empresa
  has_many   :user_models, dependent: :destroy

  attr_accessor :model_id, :cadastrar, :atualizar, :deletar, :exibir
  attr_writer   :model_id, :cadastrar, :atualizar, :deletar, :exibir

  validates :name, :email, presence: true
  validates_uniqueness_of :name, :scope => :environment_id

  class << self
    def new_by(resoure_params)
      new(name: resoure_params[:nome],
          email: resoure_params[:email],
          password: resoure_params[:password],
          admin: resoure_params[:admin])
    end
  end

  def employee?
    !self.admin?
  end

  def password_filled_in?
    return unless password.blank?
  end

  def update_with_password(resource)
    update(resource)
  end

  def import_permissoes(resoure_array)
    user_models.delete_all #necessario para atualizar ou adicionar novas permissoes
    resoure_array.each do |_key, single|
      user_models.build(model_id: single[:permissao_id].to_i, cadastrar: single[:cadastrar].to_b,
                        atualizar: single[:atualizar].to_b, exibir: single[:exibir].to_b, deletar: single[:deletar].to_b)
    end
  end

  def funcionario?
    admin.eql?(false)
  end

  def tipo
    admin ? "Administrador" : "Funcionário"
  end

  def verify_permissions_not_added
    @environment_models = []

    for i in user_models.includes("model").order("gclinic_models.name ASC").each
      for j in environment.environment_models.includes("model").order("gclinic_models.name ASC").each
        if i.model == j.model
          break
        else
          puts "Value of local variable is #{j.model.name}"
        end
      end
    end
    return @environment_models
  end
end
