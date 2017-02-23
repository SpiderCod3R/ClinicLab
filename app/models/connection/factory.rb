class Connection::Factory < ActiveRecord::Base
  self.abstract_class = true

  def self.set_connection
    spec = ActiveRecord::Base.configurations[Rails.env]
    shard_spec = spec.clone
    if(!Thread.current[:environment_type].nil?)
      shard_spec["database"] = "#{Thread.current[:environment_type]}_#{Rails.env}".to_sym
      self.establish_connection(shard_spec).connection
    else
      self.establish_connection(spec)
    end
  end
end
