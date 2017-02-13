class AddEmpresaIdToCabecs < ActiveRecord::Migration[5.0]
  def change
    add_reference :cabecs, :empresa, foreign_key: true
  end
end
