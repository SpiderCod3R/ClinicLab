class AddEmpresaIdToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_reference :convenios, :empresa, foreign_key: true
  end
end
