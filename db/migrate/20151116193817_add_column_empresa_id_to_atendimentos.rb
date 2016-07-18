class AddColumnEmpresaIdToAtendimentos < ActiveRecord::Migration
  def change
    add_reference :atendimentos, :empresa, index: true, foreign_key: true
  end
end
