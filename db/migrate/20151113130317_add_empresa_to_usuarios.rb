class AddEmpresaToUsuarios < ActiveRecord::Migration
  def change
    add_reference :usuarios, :empresa, index: true, foreign_key: true
  end
end
