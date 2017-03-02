class ImagemExterna < ApplicationRecord
  belongs_to :cliente

  class << self
    def do_cliente_atual(resource)
      where(cliente_id: resource)
    end
  end

  has_attached_file :foto_antes, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto_antes, content_type: /\Aimage\/.*\Z/
  has_attached_file :foto_depois, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto_depois, content_type: /\Aimage\/.*\Z/
end
