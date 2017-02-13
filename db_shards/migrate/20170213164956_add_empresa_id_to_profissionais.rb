class AddEmpresaIdToProfissionais < ActiveRecord::Migration[5.0]
  def change
    add_reference :profissionais, :empresa, foreign_key: true
  end
end
