class ClienteTextoLivre < Connection::Factory
  include ActiveMethods

  belongs_to :cliente
  belongs_to :texto_livre
  paginates_per 1

  class << self
    def include(resource)
      create!(cliente_id: resource[:cliente_id],
              content_data: resource[:content_data],
              texto_livre_id: resource[:texto_livre_id])
    end
  end

  def update_content(resource)
    update_attributes(content_data: resource[:content_data])
  end
end
