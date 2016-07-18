class AddConvenioReferenceToAtendimentos < ActiveRecord::Migration
  def change
    add_reference :atendimentos, :convenio, index: true, foreign_key: true
  end
end
