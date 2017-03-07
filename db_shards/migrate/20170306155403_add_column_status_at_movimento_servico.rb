class AddColumnStatusAtMovimentoServico < ActiveRecord::Migration[5.0]
  def change
    add_column :movimento_servicos, :status, :string, :limit => 30
  end
end
