class ClientePdfUpload < ApplicationRecord
  belongs_to :cliente

  has_attached_file :pdf, styles: { thumbnail: "60x60#" }

  validates_attachment :pdf,
                        content_type: { content_type: "application/pdf" },
                        size: { in: 0..10.megabytes },
                        file_name: { matches: [/pdf\z/] }

  validates :anotacoes, presence: { message: "Informe algo sobre este PDF" }, if: :file_is_present?
  validates :anotacoes, length: { maximum: 500, too_long: "%{count} número de caracteres excedido" }, if: :file_is_present?

  validate :check_content_type

  scope :ultima_data, -> { order("created_at DESC") }

  paginates_per 10

  def check_content_type
    if ['image/png', 'image/jpeg', 'image/gif',
      "application/zip", "application/x-rar",
      "application/javascript", "text/plain",
      "application/vnd.oasis.opendocument.text", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation", "application/vnd.oasis.opendocument.presentation",
      "application/vnd.oasis.opendocument.spreadsheet","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"].include?(self.pdf.content_type)
      errors.delete(:pdf)
      errors.add(:pdf, "'#{self.pdf_file_name}' - Arquivo inválido apenas documento pdf")
    end
  end

  private
    def cliente_pdf_upload
      params.require(:cliente_pdf_upload).permit(:anotacoes, :data, :cliente_id, :pdf)
    end

    def file_is_present?
      pdf.present?
    end
end
