class Gclinic::Environment < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :users, class_name: "Gclinic::User", foreign_key: "environment_id", dependent: :destroy
  accepts_nested_attributes_for :users,
                                reject_if: proc { |attributes| attributes['email'].blank?},
                                allow_destroy: true

  before_create :set_slug

  def set_slug
    slug = name.downcase.gsub(" ", "_")
  end
end
