class Gclinic::UserModel < ApplicationRecord
  belongs_to :user, class_name: "Gclinic::User"
  belongs_to :model, class_name: "Gclinic::Model"

  scope :models_added, -> {
    where("cadastrar = ? OR atualizar = ? OR exibir = ? OR deletar = ?", true, true, true, true)
  }

  def self.has_agenda?
    @model = Gclinic::Model.find_by(model_class: "Agenda")
    @user_model = where(model: @model)
    @user_model = @user_model.models_added
    return true if !@user_model.empty?
  end

  def self.has_cliente?
    @model = Gclinic::Model.find_by(model_class: "Cliente")
    @user_model = where(model: @model)
    @user_model = @user_model.models_added
    return true if !@user_model.empty?
  end
end
