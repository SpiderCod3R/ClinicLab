class AddNewColumnsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :cep, :string
    add_column :clientes, :idade, :integer
    add_column :clientes, :cor, :string
    add_column :clientes, :indicacao, :string
    add_column :clientes, :profissao, :string
    add_column :clientes, :responsavel, :string
    add_column :clientes, :hora, :string
    add_column :clientes, :observacao, :string
    add_column :clientes, :correspondencia, :string
    add_column :clientes, :data_validade_carteira, :date
    add_column :clientes, :pai, :string
    add_column :clientes, :mae, :string
    add_column :clientes, :dia_vencimento_convenio, :date
    add_column :clientes, :sequencia, :integer
    add_column :clientes, :hora_cadastro, :string
    add_column :clientes, :data_retorno, :date
    add_column :clientes, :data_ultimo_servico, :date
    add_column :clientes, :limite_vale, :float
    add_column :clientes, :num_nacional_cartao_saude, :string
    add_column :clientes, :empresa, :string
    add_column :clientes, :setor, :string
    add_column :clientes, :fonetica, :string
    add_column :clientes, :observacao_convenio, :text
    add_column :clientes, :mes_retorno, :string
    add_column :clientes, :ano_retorno, :string
    add_column :clientes, :motivo_retorno, :string
    add_column :clientes, :recem_nascido, :string
  end
end
