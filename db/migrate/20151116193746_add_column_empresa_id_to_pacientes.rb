class AddColumnEmpresaIdToPacientes < ActiveRecord::Migration
  def change
    add_reference :pacientes, :empresa, index: true, foreign_key: true
  end
end
