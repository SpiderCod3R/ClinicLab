class RemoveColumnLogoFromConfiguracaoRelatorio < ActiveRecord::Migration
  def change
    remove_column :configuracao_relatorios, :logo, :string
  end
end
