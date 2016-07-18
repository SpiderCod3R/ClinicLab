class AddEmpresaToConvenio < ActiveRecord::Migration
  def change
    add_reference :convenios, :empresa, index: true, foreign_key: true
  end
end
