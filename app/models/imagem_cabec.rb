class ImagemCabec < ApplicationRecord
  validates :imagem, :nome,  presence: true
  has_attached_file :imagem, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\Z/

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
