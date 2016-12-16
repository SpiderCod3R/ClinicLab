class AddAttachmentPdfToClientePdfUploads < ActiveRecord::Migration
  def self.up
    change_table :cliente_pdf_uploads do |t|
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :cliente_pdf_uploads, :pdf
  end
end
