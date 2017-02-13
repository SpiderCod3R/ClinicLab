class AddEmpresaIdToOperadoras < ActiveRecord::Migration[5.0]
  def change
    add_reference :operadoras, :empresa, foreign_key: true
  end
end
