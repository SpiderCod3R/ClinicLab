class Gclinic::EnvironmentModel < ApplicationRecord
  attr_accessor :model_ids
  attr_writer   :model_ids

  belongs_to :environment
  belongs_to :model

  paginates_per 10

  def name
    model.name
  end

  validates_associated :environment
  validates_uniqueness_of :model_id, :scope => :environment_id
end
