class ImagemCabec < ApplicationRecord
  include Paperclip::Glue
  validates :imagem, :nome,  presence: true
  has_attached_file :imagem, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\Z/
end
