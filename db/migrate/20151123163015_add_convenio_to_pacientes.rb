class AddConvenioToPacientes < ActiveRecord::Migration
  def change
    add_reference :pacientes, :convenio, index: true, foreign_key: true
  end
end
