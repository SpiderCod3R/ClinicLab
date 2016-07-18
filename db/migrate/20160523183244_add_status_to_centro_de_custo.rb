class AddStatusToCentroDeCusto < ActiveRecord::Migration
  def change
    add_column :centro_de_custos, :status, :string
  end
end
