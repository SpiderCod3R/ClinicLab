class AddColumnUtilizandoAgoraAtClienteConvenios < ActiveRecord::Migration[5.0]
  def change
     add_column :cliente_convenios, :utilizando_agora, :boolean, default: false
  end
end
