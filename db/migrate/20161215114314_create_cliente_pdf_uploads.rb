class CreateClientePdfUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :cliente_pdf_uploads do |t|
      t.text :anotacoes
      t.date :data
      t.references :cliente

      t.timestamps
    end
  end
end
