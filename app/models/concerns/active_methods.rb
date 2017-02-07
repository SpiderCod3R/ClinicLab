module ActiveMethods
  extend ActiveSupport::Concern
  included do
    def self.all
      self.set_connection
      super
    end

    def self.find(id)
      self.set_connection
      super(id)
    end

    def self.new(params={})
      self.set_connection
      super(params)
    end

    def self.save
      self.set_connection
      super
    end

    def self.save!
      self.set_connection
      super
    end

    def self.create(params={})
      self.set_connection
      super(params)
    end

    def self.destroy
      self.set_connection
      super
    end
  end
end