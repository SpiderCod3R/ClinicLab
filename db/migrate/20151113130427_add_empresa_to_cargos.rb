class AddEmpresaToCargos < ActiveRecord::Migration
  def change
    add_reference :cargos, :empresa, index: true, foreign_key: true
  end
end
