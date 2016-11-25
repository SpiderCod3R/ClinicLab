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

ActiveRecord::Schema.define(version: 20161125155033) do

  create_table "agenda_movimentacoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "agenda_id"
    t.integer  "convenio_id"
    t.integer  "cliente_id"
    t.text     "observacoes",       limit: 65535
    t.string   "confirmacao"
    t.boolean  "sem_convenio"
    t.date     "data"
    t.time     "hora"
    t.time     "hora_chegada"
    t.string   "sala_espera"
    t.date     "data_sala_espera"
    t.integer  "atendente_id"
    t.integer  "solicitante_id"
    t.string   "nome_paciente"
    t.string   "telefone_paciente"
    t.string   "email_paciente"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["agenda_id"], name: "index_agenda_movimentacoes_on_agenda_id", using: :btree
    t.index ["cliente_id"], name: "index_agenda_movimentacoes_on_cliente_id", using: :btree
    t.index ["convenio_id"], name: "index_agenda_movimentacoes_on_convenio_id", using: :btree
  end

  create_table "agendas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "status"
    t.date     "data"
    t.string   "atendimento_duracao"
    t.string   "atendimento_inicio"
    t.string   "atendimento_final"
    t.time     "hora_atendimento"
    t.boolean  "atendimento_sabado"
    t.boolean  "atendimento_domingo"
    t.integer  "empresa_id"
    t.integer  "usuario_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "referencia_agenda_id"
    t.string   "periodo"
    t.index ["empresa_id"], name: "index_agendas_on_empresa_id", using: :btree
    t.index ["referencia_agenda_id"], name: "index_agendas_on_referencia_agenda_id", using: :btree
    t.index ["usuario_id"], name: "index_agendas_on_usuario_id", using: :btree
  end

  create_table "atendimentos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "rg"
    t.string   "cpf"
    t.date     "data_nascimento"
    t.string   "telefone"
    t.string   "celular"
    t.string   "nome_da_mae"
    t.string   "endereco"
    t.string   "bairro"
    t.string   "cep"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.date     "data"
    t.time     "hora"
    t.integer  "convenio_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "empresa_id"
    t.index ["cidade_id"], name: "index_atendimentos_on_cidade_id", using: :btree
    t.index ["convenio_id"], name: "index_atendimentos_on_convenio_id", using: :btree
    t.index ["empresa_id"], name: "index_atendimentos_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_atendimentos_on_estado_id", using: :btree
  end

  create_table "cabecs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.text     "texto",      limit: 65535
    t.boolean  "status",                   default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_cabecs_on_empresa_id", using: :btree
  end

  create_table "cargos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_cargos_on_empresa_id", using: :btree
  end

  create_table "centro_de_custos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_centro_de_custos_on_empresa_id", using: :btree
  end

  create_table "cidades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "clientes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.boolean  "status"
    t.string   "nome"
    t.string   "cpf"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "email"
    t.string   "telefone"
    t.string   "sexo"
    t.string   "rg"
    t.string   "estado_civil"
    t.date     "nascimento"
    t.string   "produto"
    t.boolean  "status_convenio"
    t.string   "matricula"
    t.string   "titular"
    t.string   "plano"
    t.date     "validade_carteira"
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.integer  "cargo_id"
    t.integer  "convenio_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "empresa_id"
    t.string   "nacionalidade"
    t.string   "naturalidade"
    t.index ["cargo_id"], name: "index_clientes_on_cargo_id", using: :btree
    t.index ["cidade_id"], name: "index_clientes_on_cidade_id", using: :btree
    t.index ["convenio_id"], name: "index_clientes_on_convenio_id", using: :btree
    t.index ["empresa_id"], name: "index_clientes_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_clientes_on_estado_id", using: :btree
  end

  create_table "configuracao_relatorios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "nome_empresa"
    t.string   "cnpj"
    t.string   "telefone"
    t.string   "endereco"
    t.string   "bairro"
    t.string   "cidade_estado"
    t.string   "email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_configuracao_relatorios_on_empresa_id", using: :btree
  end

  create_table "conselho_regionais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sigla"
    t.text     "descricao",  limit: 65535
    t.boolean  "status",                   default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_conselho_regionais_on_empresa_id", using: :btree
  end

  create_table "convenios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.decimal  "valor",      precision: 14, scale: 2
    t.boolean  "status",                              default: true
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_convenios_on_empresa_id", using: :btree
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
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.string   "documento"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empresa_id"
    t.index ["cidade_id"], name: "index_fornecedores_on_cidade_id", using: :btree
    t.index ["empresa_id"], name: "index_fornecedores_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_fornecedores_on_estado_id", using: :btree
  end

  create_table "historicos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "indice",     limit: 65535
    t.integer  "cliente_id"
    t.string   "idade"
    t.integer  "usuario_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["cliente_id"], name: "index_historicos_on_cliente_id", using: :btree
  end

  create_table "imagem_cabecs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string   "imagem"
    t.string   "nome"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_imagem_cabecs_on_empresa_id", using: :btree
  end

  create_table "operadoras", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_operadoras_on_empresa_id", using: :btree
  end

  create_table "painel_empresa_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "permissao_id"
    t.integer  "empresa_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "painel_empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.boolean  "status"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_painel_empresas_on_slug", unique: true, using: :btree
  end

  create_table "painel_masters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "nome"
    t.string   "login"
    t.boolean  "desenvolvedor",          default: false
    t.index ["email"], name: "index_painel_masters_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_painel_masters_on_reset_password_token", unique: true, using: :btree
  end

  create_table "painel_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "model_class"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "painel_usuario_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "usuario_id"
    t.integer  "permissao_id"
    t.boolean  "cadastrar"
    t.boolean  "atualizar"
    t.boolean  "exibir"
    t.boolean  "deletar"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "painel_usuarios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.string   "nome"
    t.boolean  "admin"
    t.integer  "empresa_id"
    t.string   "login"
    t.string   "telefone"
    t.integer  "codigo_pais"
    t.index ["email"], name: "index_painel_usuarios_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_painel_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  create_table "profissionais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
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
    t.integer  "cargo_id"
    t.integer  "conselho_regional_id"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.integer  "operadora_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "empresa_id"
    t.index ["cargo_id"], name: "index_profissionais_on_cargo_id", using: :btree
    t.index ["cidade_id"], name: "index_profissionais_on_cidade_id", using: :btree
    t.index ["conselho_regional_id"], name: "index_profissionais_on_conselho_regional_id", using: :btree
    t.index ["empresa_id"], name: "index_profissionais_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_profissionais_on_estado_id", using: :btree
    t.index ["operadora_id"], name: "index_profissionais_on_operadora_id", using: :btree
  end

  create_table "referencia_agendas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "descricao"
    t.boolean  "status"
    t.integer  "profissional_id"
    t.integer  "empresa_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["profissional_id"], name: "index_referencia_agendas_on_profissional_id", using: :btree
  end

  create_table "servicos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "tipo"
    t.string   "abreviatura"
    t.integer  "empresa_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["empresa_id"], name: "index_servicos_on_empresa_id", using: :btree
  end

  create_table "texto_livres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "servico_id"
    t.integer  "empresa_id"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["empresa_id"], name: "index_texto_livres_on_empresa_id", using: :btree
    t.index ["servico_id"], name: "index_texto_livres_on_servico_id", using: :btree
  end

  add_foreign_key "agenda_movimentacoes", "agendas"
  add_foreign_key "agenda_movimentacoes", "clientes"
  add_foreign_key "agenda_movimentacoes", "convenios"
  add_foreign_key "agendas", "referencia_agendas"
  add_foreign_key "atendimentos", "cidades"
  add_foreign_key "atendimentos", "convenios"
  add_foreign_key "atendimentos", "estados"
  add_foreign_key "clientes", "cargos"
  add_foreign_key "clientes", "cidades"
  add_foreign_key "clientes", "convenios"
  add_foreign_key "clientes", "estados"
  add_foreign_key "fornecedores", "cidades"
  add_foreign_key "fornecedores", "estados"
  add_foreign_key "historicos", "clientes"
  add_foreign_key "profissionais", "cargos"
  add_foreign_key "profissionais", "cidades"
  add_foreign_key "profissionais", "conselho_regionais"
  add_foreign_key "profissionais", "estados"
  add_foreign_key "profissionais", "operadoras"
  add_foreign_key "referencia_agendas", "profissionais"
  add_foreign_key "texto_livres", "servicos"
end
