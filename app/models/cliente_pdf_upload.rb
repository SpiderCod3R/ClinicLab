class ClientePdfUpload < ApplicationRecord
  belongs_to :cliente

  has_attached_file :pdf, styles: { thumbnail: "60x60#" }
  validates_attachment :pdf, presence: true,
    content_type: { content_type: "application/pdf" },
    size: { in: 0..5.megabytes }
  validates_attachment_file_name :pdf, matches: [/pdf\z/]

  validates :anotacoes, :data, :pdf, presence: true

  private
    def cliente_pdf_upload
      params.require(:cliente_pdf_upload).permit(:anotacoes, :data, :cliente_id, :pdf)
    end
end
