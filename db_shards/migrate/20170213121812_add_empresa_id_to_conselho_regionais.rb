class AddEmpresaIdToConselhoRegionais < ActiveRecord::Migration[5.0]
  def change
    add_reference :conselho_regionais, :empresa, foreign_key: true
  end
end
