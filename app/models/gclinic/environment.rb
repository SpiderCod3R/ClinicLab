class Gclinic::Environment < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessor :model_ids
  attr_writer   :model_ids

  has_many :users, class_name: "Gclinic::User", foreign_key: "environment_id", dependent: :destroy
  accepts_nested_attributes_for :users,
                                reject_if: proc { |attributes| attributes['email'].blank?},
                                allow_destroy: true

  before_create :set_slug
  has_many :environment_models, dependent: :destroy
  has_many :models, through: :environment_models

  accepts_nested_attributes_for :environment_models,
                                reject_if: proc { |attributes| attributes['model_id'].blank?},
                                allow_destroy: true

  def set_slug
    slug = name.downcase.gsub(" ", "_")
  end

  def import_all_models
    Gclinic::Model.all.each do |model|
      self.environment_models.build(model_id: model.id)
    end
    self.save
  end

  def import_models(resource)
    resource[:model_ids].delete("")
    resource[:model_ids].each do |id|
      self.environment_models.build(model_id: id)
    end

    begin
      self.save
    rescue ActiveRecord::RecordInvalid
      Rails.logger.warn { "Encountered a non-fatal RecordNotUnique error for: #{handle}" }
      retry
    rescue => e
      Rails.logger.error { "Encountered an error when trying to find or create Person for: #{handle}, #{e.message} #{e.backtrace.join("\n")}" }
      nil
    end
  end
end
