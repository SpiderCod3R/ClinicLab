class AddViaAndObservacoesToClienteConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :cliente_convenios, :via, :string
    add_column :cliente_convenios, :observacoes, :text
  end
end
