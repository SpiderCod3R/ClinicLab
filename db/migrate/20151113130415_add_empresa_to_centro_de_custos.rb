class AddEmpresaToCentroDeCustos < ActiveRecord::Migration
  def change
    add_reference :centro_de_custos, :empresa, index: true, foreign_key: true
  end
end
