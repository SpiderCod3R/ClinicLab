class AddNumeroConselhoRegionalToProfissionais < ActiveRecord::Migration[5.0]
  def change
    add_column :profissionais, :numero_conselho_regional, :string
  end
end
