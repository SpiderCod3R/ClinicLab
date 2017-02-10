class Gclinic::UserModel < ApplicationRecord
  belongs_to :user, class_name: "Gclinic::User"
  belongs_to :model, class_name: "Gclinic::Model"
end
