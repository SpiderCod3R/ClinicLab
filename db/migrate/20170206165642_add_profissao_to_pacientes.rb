class AddProfissaoToPacientes < ActiveRecord::Migration[5.0]
  def change
    add_column :pacientes, :profissao, :string
  end
end
