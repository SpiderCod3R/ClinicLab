class AddEmpresaIdToConfiguracaoRelatorios < ActiveRecord::Migration[5.0]
  def change
    add_reference :configuracao_relatorios, :empresa, foreign_key: true
  end
end
