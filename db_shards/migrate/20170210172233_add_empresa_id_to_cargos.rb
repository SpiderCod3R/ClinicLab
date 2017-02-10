class AddEmpresaIdToCargos < ActiveRecord::Migration[5.0]
  def change
    add_reference :cargos, :empresa, foreign_key: true
  end
end
