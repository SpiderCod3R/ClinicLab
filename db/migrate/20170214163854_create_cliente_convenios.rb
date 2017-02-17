class CreateClienteConvenios < ActiveRecord::Migration[5.0]
  def change
    create_table :cliente_convenios do |t|
      t.belongs_to :cliente, foreign_key: true
      t.belongs_to :convenio, foreign_key: true
      t.boolean :status_convenio
      t.string :matricula
      t.string :titular
      t.string :plano
      t.date :validade_carteira
      t.string :produto
    end
  end
end
