class CreatePacientes < ActiveRecord::Migration[5.0]
  def change
    create_table :pacientes do |t|

      t.attachment :foto
      t.string :status
      t.string :nome
      t.string :cpf
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.string :email
      t.string :telefone
      t.string :sexo
      t.string :rg
      t.string :estado_civil
      t.date :nascimento

      t.string :produto
      t.string :status_convenio
      t.string :matricula
      t.string :titular
      t.string :plano
      t.date   :validade_carteira
      t.string :nacionalidade
      t.string :naturalidade
      t.string :mes
      t.string :tipo_sanguineo
      t.date   :data_da_ultima_consulta
      t.date   :data_obito
      t.float  :peso
      t.text   :como_soube
      t.float  :altura
      t.string :cep
      t.string :cor
      t.string :sexo
      t.string :indicacao
      t.string :profissional
      t.string :observacao
      t.string :correspondencia
      t.string :pai
      t.string :mae
      t.string :dia_vencimento_convenio
      t.integer :sequencia
      t.date :data_retorno
      t.date :data_ultimo_servico
      t.integer :limite_vale
      t.string :plano
      t.string :num_nacional_cartao_saude
      t.string :empresa
      t.string :setor
      t.string :fonetica
      t.string :cidade
      t.string :uf
      t.string :observacao_convenio
      t.string :mes_retorno
      t.string :ano_retorno
      t.string :motivo_retorno
      t.string :recem_nascido               


       t.belongs_to :convenio, index: true, foreign_key: true


      t.timestamps
    end
  end
end
