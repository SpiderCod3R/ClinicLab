class AddDesenvolvedorToPainelMasters < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_masters, :desenvolvedor, :boolean, default: 0
  end
end
