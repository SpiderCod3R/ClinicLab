module AtivandoStatus
  extend ActiveSupport::Concern
  included do
    before_create :set_status_to_valido?
private
    def set_status_to_valido?
      self.status = true
    end
  end
end