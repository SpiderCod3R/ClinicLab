class ClientePdfUpload < ApplicationRecord
  belongs_to :cliente

  has_attached_file :pdf, styles: { thumbnail: "60x60#" }

  validates_attachment :pdf,
                        content_type: { content_type: "application/pdf" },
                        size: { in: 0..5.megabytes },
                        matches: { [/pdf\z/], message: "Formato inválido - Apenas documento pdf" }

  # validates_attachment_file_name :pdf, message: "Formato inválido - Apenas documento pdf"

  validates :anotacoes, presence: { message: "Informe algo sobre este PDF" }, if: :file_is_present?
  validates :anotacoes, length: { maximum: 500, too_long: "%{count} número de caracteres excedido" }, if: :file_is_present?

  scope :ultima_data, -> { order("created_at DESC") }

  paginates_per 10

  private
    def cliente_pdf_upload
      params.require(:cliente_pdf_upload).permit(:anotacoes, :data, :cliente_id, :pdf)
    end

    def file_is_present?
      pdf.present?
    end
end
