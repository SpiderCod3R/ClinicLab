class AddNumNacionalCartaoSaudeToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :num_nacional_cartao_saude, :string
  end
end
