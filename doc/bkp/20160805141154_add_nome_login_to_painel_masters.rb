class AddNomeLoginToPainelMasters < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_masters, :nome, :string
    add_column :painel_masters, :login, :string
  end
end
