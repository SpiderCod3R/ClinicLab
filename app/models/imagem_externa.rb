class ImagemExterna < Connection::Factory
  include ActiveMethods

  belongs_to :cliente

  class << self
    def do_cliente_atual(resource)
      where(cliente_id: resource)
    end
  end

  has_attached_file :foto_antes
  has_attached_file :foto_depois

  validates_with AttachmentSizeValidator, attributes: :foto_antes, less_than: 10.megabytes
  validates_with AttachmentSizeValidator, attributes: :foto_depois, less_than: 10.megabytes

  validates_attachment :foto_antes, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"], message: "Esta imagem não possui um formato válido. Apenas JPEG - JPG - PNG" }
  validates_attachment :foto_depois, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"], message: "Esta imagem não possui um formato válido. Apenas JPEG - JPG - PNG" }

  validates_attachment_file_name :foto_antes, matches: [/png\z/, /jpe?g\z/, /jp?g\z/], message: "Esta imagem não possui um formato válido. Apenas JPEG - JPG - PNG"
  validates_attachment_file_name :foto_depois, matches: [/png\z/, /jpe?g\z/, /jp?g\z/], message: "Esta imagem não possui um formato válido. Apenas JPEG - JPG - PNG"
end
