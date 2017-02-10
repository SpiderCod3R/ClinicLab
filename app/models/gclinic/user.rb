class Gclinic::User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :environment, class_name: "Gclinic::Environment"
  belongs_to :empresa, class_name: "Empresa"
  has_many   :user_models, dependent: :destroy


  attr_accessor :model_id, :cadastrar, :atualizar, :deletar, :exibir
  attr_writer   :model_id, :cadastrar, :atualizar, :deletar, :exibir
end
