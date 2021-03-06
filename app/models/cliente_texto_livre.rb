class ClienteTextoLivre < Connection::Factory
  include ActiveMethods

  belongs_to :cliente
  belongs_to :texto_livre
  # paginates_per 1


  class << self
    def include(resource)
      create!(cliente_id: resource[:cliente_id],
              content_data: resource[:content],
              texto_livre_id: resource[:texto_livre_id])
    end
  end

  def update_content(resource)
    update(content_data: resource[:content])
    self.texto_livre_id= resource[:texto_livre_id]
    self.save
  end

  def next
    self.class.where("id < ? AND cliente_id = ?", id, cliente_id).last
  end

  def previous
    self.class.where("id > ? AND cliente_id = ?", id, cliente_id).first
  end
end
