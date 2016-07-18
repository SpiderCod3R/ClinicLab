class AddEstadoCidadeToPacientes < ActiveRecord::Migration
  def change
    add_reference :pacientes, :estado, index: true, foreign_key: true
    add_reference :pacientes, :cidade, index: true, foreign_key: true
  end
end
