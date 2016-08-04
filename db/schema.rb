# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160804145312) do

  create_table "atendimentos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "rg"
    t.string   "cpf"
    t.string   "telefone"
    t.string   "celular"
    t.string   "nome_da_mae"
    t.string   "endereco"
    t.string   "bairro"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "empresa_id"
    t.date     "data"
    t.time     "hora"
    t.integer  "convenio_id"
    t.date     "data_nascimento"
    t.string   "cep"
    t.index ["cidade_id"], name: "index_atendimentos_on_cidade_id", using: :btree
    t.index ["convenio_id"], name: "index_atendimentos_on_convenio_id", using: :btree
    t.index ["empresa_id"], name: "index_atendimentos_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_atendimentos_on_estado_id", using: :btree
  end

  create_table "cabecs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.text     "texto",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "status"
  end

  create_table "cargos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "empresa_id"
    t.string   "status"
    t.index ["empresa_id"], name: "index_cargos_on_empresa_id", using: :btree
  end

  create_table "centro_de_custos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "empresa_id"
    t.string   "status"
    t.index ["empresa_id"], name: "index_centro_de_custos_on_empresa_id", using: :btree
  end

  create_table "cidades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "status"
    t.string   "nome"
    t.string   "cpf"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "estado_id"
    t.string   "cidade_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.string   "email"
    t.string   "telefone"
    t.integer  "cargo_id"
    t.string   "status_convenio"
    t.string   "matricula"
    t.string   "plano"
    t.date     "validade_carteira"
    t.string   "produto"
    t.string   "titular"
    t.integer  "convenio_id"
    t.date     "nascimento"
    t.string   "sexo"
    t.string   "rg"
    t.string   "estado_civil"
    t.integer  "empresa_id"
    t.index ["cargo_id"], name: "index_clientes_on_cargo_id", using: :btree
    t.index ["convenio_id"], name: "index_clientes_on_convenio_id", using: :btree
    t.index ["empresa_id"], name: "index_clientes_on_empresa_id", using: :btree
  end

  create_table "configuracao_relatorios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome_empresa"
    t.string   "cnpj"
    t.string   "telefone"
    t.string   "endereco"
    t.string   "bairro"
    t.string   "cidade_estado"
    t.string   "email"
    t.integer  "empresa_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "conselho_regionais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sigla"
    t.text     "descricao",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "status"
  end

  create_table "convenios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.decimal  "valor",      precision: 14, scale: 2
    t.decimal  "decimal",    precision: 14, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "empresa_id"
    t.string   "status"
    t.index ["empresa_id"], name: "index_convenios_on_empresa_id", using: :btree
  end

  create_table "empresa_permissao_empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "empresa_id"
    t.integer  "permissao_empresa_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["empresa_id"], name: "index_empresa_permissao_empresas_on_empresa_id", using: :btree
    t.index ["permissao_empresa_id"], name: "index_empresa_permissao_empresas_on_permissao_empresa_id", using: :btree
  end

  create_table "empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sigla"
    t.string   "nome"
    t.integer  "capital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fornecedores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "status"
    t.string   "nome"
    t.string   "cpf"
    t.string   "cnpj"
    t.string   "email"
    t.string   "telefone"
    t.string   "celular"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "bairro"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.string   "documento"
    t.index ["cidade_id"], name: "index_fornecedores_on_cidade_id", using: :btree
    t.index ["estado_id"], name: "index_fornecedores_on_estado_id", using: :btree
  end

  create_table "funcoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imagem_cabecs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string   "imagem"
    t.string   "nome"
  end

  create_table "operadoras", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "empresa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "pacientes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "rg"
    t.string   "cpf"
    t.date     "data_nascimento"
    t.string   "telefone"
    t.string   "nome_da_mae"
    t.string   "endereco"
    t.string   "bairro"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.string   "localizacao",     default: "Brasil"
    t.integer  "empresa_id"
    t.integer  "convenio_id"
    t.string   "cep"
    t.string   "celular"
    t.index ["cidade_id"], name: "index_pacientes_on_cidade_id", using: :btree
    t.index ["convenio_id"], name: "index_pacientes_on_convenio_id", using: :btree
    t.index ["empresa_id"], name: "index_pacientes_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_pacientes_on_estado_id", using: :btree
  end

  create_table "painel_empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "painel_masters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_painel_masters_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_painel_masters_on_reset_password_token", unique: true, using: :btree
  end

  create_table "painel_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "model_class"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "permissao_empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "modulo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nome"
  end

  create_table "profissionais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "status"
    t.string   "rg"
    t.string   "cpf"
    t.string   "telefone"
    t.string   "celular"
    t.date     "data_nascimento"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "cargo_id"
    t.integer  "conselho_regional_id"
    t.integer  "cidade_id"
    t.integer  "empresa_id"
    t.integer  "estado_id"
    t.integer  "operadora_id"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.index ["cargo_id"], name: "index_profissionais_on_cargo_id", using: :btree
    t.index ["cidade_id"], name: "index_profissionais_on_cidade_id", using: :btree
    t.index ["conselho_regional_id"], name: "index_profissionais_on_conselho_regional_id", using: :btree
    t.index ["empresa_id"], name: "index_profissionais_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_profissionais_on_estado_id", using: :btree
    t.index ["operadora_id"], name: "index_profissionais_on_operadora_id", using: :btree
  end

  create_table "texto_livres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.text     "texto",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "usuario_permissao_empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "usuario_id"
    t.integer  "permissao_empresa_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "cadastrar"
    t.boolean  "editar"
    t.boolean  "visualizar"
    t.boolean  "excluir"
    t.index ["permissao_empresa_id"], name: "index_usuario_permissao_empresas_on_permissao_empresa_id", using: :btree
    t.index ["usuario_id"], name: "index_usuario_permissao_empresas_on_usuario_id", using: :btree
  end

  create_table "usuarios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "nome"
    t.boolean  "ativo",                  default: true
    t.integer  "funcao_id"
    t.integer  "empresa_id"
    t.string   "username"
    t.index ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
    t.index ["empresa_id"], name: "index_usuarios_on_empresa_id", using: :btree
    t.index ["funcao_id"], name: "index_usuarios_on_funcao_id", using: :btree
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "atendimentos", "cidades"
  add_foreign_key "atendimentos", "convenios"
  add_foreign_key "atendimentos", "empresas"
  add_foreign_key "atendimentos", "estados"
  add_foreign_key "cargos", "empresas"
  add_foreign_key "centro_de_custos", "empresas"
  add_foreign_key "clientes", "cargos"
  add_foreign_key "clientes", "convenios"
  add_foreign_key "clientes", "empresas"
  add_foreign_key "convenios", "empresas"
  add_foreign_key "empresa_permissao_empresas", "empresas"
  add_foreign_key "empresa_permissao_empresas", "permissao_empresas"
  add_foreign_key "fornecedores", "cidades"
  add_foreign_key "fornecedores", "estados"
  add_foreign_key "pacientes", "cidades"
  add_foreign_key "pacientes", "convenios"
  add_foreign_key "pacientes", "empresas"
  add_foreign_key "pacientes", "estados"
  add_foreign_key "profissionais", "cargos"
  add_foreign_key "profissionais", "cidades"
  add_foreign_key "profissionais", "conselho_regionais"
  add_foreign_key "profissionais", "empresas"
  add_foreign_key "profissionais", "estados"
  add_foreign_key "profissionais", "operadoras"
  add_foreign_key "usuario_permissao_empresas", "permissao_empresas"
  add_foreign_key "usuario_permissao_empresas", "usuarios"
  add_foreign_key "usuarios", "empresas"
  add_foreign_key "usuarios", "funcoes"
end
