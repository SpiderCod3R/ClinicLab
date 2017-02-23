class AddEmpresaToAllModulesAlreadyCreated < ActiveRecord::Migration[5.0]
  def change
    add_reference :atendimentos,            :empresa, index: true
    add_reference :clientes,                :empresa, index: true
    add_reference :cabecs,                  :empresa, index: true
    add_reference :convenios,               :empresa, index: true
    add_reference :cargos,                  :empresa, index: true
    add_reference :centro_de_custos,        :empresa, index: true
    add_reference :conselho_regionais,      :empresa, index: true
    add_reference :configuracao_relatorios, :empresa, index: true
    add_reference :operadoras,              :empresa, index: true
    add_reference :fornecedores,            :empresa, index: true
    add_reference :imagem_cabecs,           :empresa, index: true
    add_reference :profissionais,           :empresa, index: true
  end
end
