class AddEmpresaIdToCentroDeCustos < ActiveRecord::Migration[5.0]
  def change
    add_reference :centro_de_custos, :empresa, foreign_key: true
  end
end
