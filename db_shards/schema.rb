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

ActiveRecord::Schema.define(version: 20170825114341) do

  create_table "agenda_movimentacoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "agenda_id"
    t.integer  "convenio_id"
    t.integer  "cliente_id"
    t.text     "observacoes",         limit: 65535
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
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "cliente_convenio_id"
    t.string   "indicacao"
    t.index ["agenda_id"], name: "index_agenda_movimentacoes_on_agenda_id", using: :btree
    t.index ["cliente_convenio_id"], name: "index_agenda_movimentacoes_on_cliente_convenio_id", using: :btree
    t.index ["cliente_id"], name: "index_agenda_movimentacoes_on_cliente_id", using: :btree
    t.index ["convenio_id"], name: "index_agenda_movimentacoes_on_convenio_id", using: :btree
  end

  create_table "agenda_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_model_id"
    t.boolean  "agendar"
    t.boolean  "excluir"
    t.boolean  "trocar_horario"
    t.boolean  "realizar_atendimento"
    t.boolean  "visualizar_atendimento"
    t.boolean  "limpar_horario"
    t.boolean  "paciente_nao_veio"
    t.boolean  "remarcar_pelo_paciente"
    t.boolean  "remarcar_pelo_medico"
    t.boolean  "desmarcar_pelo_medico"
    t.boolean  "desmarcar_pelo_paciente"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "sala_espera"
    t.boolean  "movimento_servico"
    t.index ["user_model_id"], name: "index_agenda_permissoes_on_user_model_id", using: :btree
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
    t.index ["cidade_id"], name: "index_atendimentos_on_cidade_id", using: :btree
    t.index ["convenio_id"], name: "index_atendimentos_on_convenio_id", using: :btree
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
    t.index ["estado_id"], name: "index_cidades_on_estado_id", using: :btree
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

  create_table "cliente_convenios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "cliente_id"
    t.integer "convenio_id"
    t.boolean "status_convenio"
    t.string  "matricula"
    t.string  "titular"
    t.string  "plano"
    t.date    "validade_carteira"
    t.string  "produto"
    t.boolean "utilizando_agora",                default: false
    t.string  "via"
    t.text    "observacoes",       limit: 65535
    t.index ["cliente_id"], name: "index_cliente_convenios_on_cliente_id", using: :btree
    t.index ["convenio_id"], name: "index_cliente_convenios_on_convenio_id", using: :btree
  end

  create_table "cliente_pdf_uploads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "anotacoes",        limit: 65535
    t.date     "data"
    t.integer  "cliente_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.index ["cliente_id"], name: "index_cliente_pdf_uploads_on_cliente_id", using: :btree
  end

  create_table "cliente_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_model_id"
    t.boolean  "historico"
    t.boolean  "texto_livre"
    t.boolean  "pdf_upload"
    t.integer  "empresa_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "receituario"
    t.boolean  "imagens_externas"
    t.index ["empresa_id"], name: "index_cliente_permissoes_on_empresa_id", using: :btree
  end

  create_table "cliente_receituarios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cliente_id"
    t.integer  "user_id"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "cabecalho"
    t.string   "receitas"
    t.index ["cliente_id"], name: "index_cliente_receituarios_on_cliente_id", using: :btree
  end

  create_table "cliente_texto_livres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cliente_id"
    t.text     "content_data",   limit: 65535
    t.integer  "texto_livre_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "cabecalho"
    t.integer  "usuario_id"
    t.index ["cliente_id"], name: "index_cliente_texto_livres_on_cliente_id", using: :btree
    t.index ["texto_livre_id"], name: "index_cliente_texto_livres_on_texto_livre_id", using: :btree
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
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.integer  "cargo_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "nacionalidade"
    t.string   "naturalidade"
    t.string   "mes"
    t.string   "tipo_sanguineo"
    t.date     "data_da_ultima_consulta"
    t.date     "data_obito"
    t.float    "peso",                       limit: 24
    t.text     "como_soube",                 limit: 65535
    t.float    "altura",                     limit: 24
    t.integer  "empresa_id"
    t.string   "cep"
    t.integer  "idade"
    t.string   "cor"
    t.string   "indicacao"
    t.string   "profissao"
    t.string   "responsavel"
    t.string   "hora"
    t.string   "observacao"
    t.string   "correspondencia"
    t.date     "data_validade_carteira"
    t.string   "pai"
    t.string   "mae"
    t.date     "dia_vencimento_convenio"
    t.integer  "sequencia"
    t.string   "hora_cadastro"
    t.date     "data_retorno"
    t.date     "data_ultimo_servico"
    t.float    "limite_vale",                limit: 24
    t.string   "num_nacional_cartao_saude"
    t.string   "empresa"
    t.string   "setor"
    t.string   "fonetica"
    t.text     "observacao_convenio",        limit: 65535
    t.string   "mes_retorno"
    t.string   "ano_retorno"
    t.string   "motivo_retorno"
    t.string   "recem_nascido"
    t.string   "cidade_old"
    t.string   "estado_old"
    t.string   "convenio"
    t.string   "matricula"
    t.string   "titular"
    t.date     "data_cadastro"
    t.string   "alertar"
    t.text     "historico",                  limit: 65535
    t.string   "plano"
    t.string   "atendente"
    t.date     "data_atualizacao"
    t.text     "observacoes",                limit: 65535
    t.string   "flag"
    t.string   "foto"
    t.string   "atualizador"
    t.string   "atualizador_historico"
    t.string   "hora_atualizacao"
    t.string   "data_atualizacao_historico"
    t.string   "hora_atualizacao_historico"
    t.string   "alertar_paciente"
    t.index ["cargo_id"], name: "index_clientes_on_cargo_id", using: :btree
    t.index ["cidade_id"], name: "index_clientes_on_cidade_id", using: :btree
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
    t.decimal  "valor",           precision: 14, scale: 2
    t.boolean  "status",                                   default: true
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "telefone"
    t.string   "endereco"
    t.string   "bairro"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.string   "cep"
    t.string   "cnpj"
    t.string   "referencia"
    t.string   "registroons"
    t.string   "nundiasvalsenha"
    t.string   "sigla"
    t.integer  "codigo"
    t.integer  "empresa_id"
    t.string   "contato"
    t.string   "matricula"
    t.decimal  "valorchconsulta", precision: 14, scale: 2
    t.decimal  "valorchservico",  precision: 14, scale: 2
    t.string   "tipopessoa"
    t.index ["empresa_id"], name: "index_convenios_on_empresa_id", using: :btree
  end

  create_table "empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "slug"
    t.string   "environment_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "environment_id"
  end

  create_table "estados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sigla"
    t.string   "nome"
    t.integer  "capital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feriado_e_data_comemorativas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "data"
    t.string   "descricao"
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

  create_table "imagens_externas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "foto_antes_file_name"
    t.string   "foto_antes_content_type"
    t.integer  "foto_antes_file_size"
    t.datetime "foto_antes_updated_at"
    t.string   "foto_depois_file_name"
    t.string   "foto_depois_content_type"
    t.integer  "foto_depois_file_size"
    t.datetime "foto_depois_updated_at"
    t.integer  "cliente_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["cliente_id"], name: "index_imagens_externas_on_cliente_id", using: :btree
  end

  create_table "movimento_servico_servicos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "servico_id"
    t.integer  "movimento_servico_id"
    t.decimal  "valor_servico",        precision: 14, scale: 2
    t.integer  "empresa_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["empresa_id"], name: "index_movimento_servico_servicos_on_empresa_id", using: :btree
    t.index ["movimento_servico_id"], name: "index_movimento_servico_servicos_on_movimento_servico_id", using: :btree
    t.index ["servico_id"], name: "index_movimento_servico_servicos_on_servico_id", using: :btree
  end

  create_table "movimento_servicos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "atendente_id"
    t.integer  "atualizador_id"
    t.integer  "cliente_id"
    t.integer  "convenio_id"
    t.integer  "solicitante_id"
    t.integer  "medico_id"
    t.date     "data_entrada"
    t.time     "hora_entrada"
    t.decimal  "valor_total",                       precision: 14, scale: 2
    t.integer  "empresa_id"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "status",                 limit: 30
    t.decimal  "valor_desconto",                    precision: 14, scale: 2
    t.decimal  "valor_servicos",                    precision: 14, scale: 2
    t.integer  "agenda_movimentacao_id"
    t.index ["agenda_movimentacao_id"], name: "index_movimento_servicos_on_agenda_movimentacao_id", using: :btree
    t.index ["cliente_id"], name: "index_movimento_servicos_on_cliente_id", using: :btree
    t.index ["convenio_id"], name: "index_movimento_servicos_on_convenio_id", using: :btree
    t.index ["empresa_id"], name: "index_movimento_servicos_on_empresa_id", using: :btree
  end

  create_table "operadoras", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "empresa_id"
    t.index ["empresa_id"], name: "index_operadoras_on_empresa_id", using: :btree
  end

  create_table "painel_permissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "model_class"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "numero_conselho_regional"
    t.integer  "empresa_id"
    t.index ["cargo_id"], name: "index_profissionais_on_cargo_id", using: :btree
    t.index ["cidade_id"], name: "index_profissionais_on_cidade_id", using: :btree
    t.index ["conselho_regional_id"], name: "index_profissionais_on_conselho_regional_id", using: :btree
    t.index ["empresa_id"], name: "index_profissionais_on_empresa_id", using: :btree
    t.index ["estado_id"], name: "index_profissionais_on_estado_id", using: :btree
    t.index ["operadora_id"], name: "index_profissionais_on_operadora_id", using: :btree
  end

  create_table "receituarios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "slug"
    t.text     "receita",    limit: 65535
    t.integer  "empresa_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["empresa_id"], name: "index_receituarios_on_empresa_id", using: :btree
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

  create_table "sala_esperas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cliente_id"
    t.integer  "agenda_id"
    t.date     "data"
    t.string   "status"
    t.datetime "hora_agendada"
    t.datetime "hora_chegada"
    t.datetime "hora_inicio_atendimento"
    t.datetime "hora_fim_atendimento"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["agenda_id"], name: "index_sala_esperas_on_agenda_id", using: :btree
    t.index ["cliente_id"], name: "index_sala_esperas_on_cliente_id", using: :btree
  end

  create_table "servicos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "tipo"
    t.string   "abreviatura"
    t.integer  "empresa_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "valor",       precision: 14, scale: 2
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
  add_foreign_key "agenda_movimentacoes", "cliente_convenios"
  add_foreign_key "agenda_movimentacoes", "clientes"
  add_foreign_key "agenda_movimentacoes", "convenios"
  add_foreign_key "agendas", "referencia_agendas"
  add_foreign_key "atendimentos", "cidades"
  add_foreign_key "atendimentos", "convenios"
  add_foreign_key "atendimentos", "estados"
  add_foreign_key "cabecs", "empresas"
  add_foreign_key "cargos", "empresas"
  add_foreign_key "centro_de_custos", "empresas"
  add_foreign_key "cliente_convenios", "clientes"
  add_foreign_key "cliente_convenios", "convenios"
  add_foreign_key "cliente_receituarios", "clientes"
  add_foreign_key "cliente_texto_livres", "clientes"
  add_foreign_key "cliente_texto_livres", "texto_livres"
  add_foreign_key "clientes", "cargos"
  add_foreign_key "clientes", "cidades"
  add_foreign_key "clientes", "empresas"
  add_foreign_key "clientes", "estados"
  add_foreign_key "configuracao_relatorios", "empresas"
  add_foreign_key "conselho_regionais", "empresas"
  add_foreign_key "convenios", "empresas"
  add_foreign_key "fornecedores", "cidades"
  add_foreign_key "fornecedores", "empresas"
  add_foreign_key "fornecedores", "estados"
  add_foreign_key "historicos", "clientes"
  add_foreign_key "imagem_cabecs", "empresas"
  add_foreign_key "imagens_externas", "clientes"
  add_foreign_key "movimento_servico_servicos", "movimento_servicos"
  add_foreign_key "movimento_servico_servicos", "servicos"
  add_foreign_key "movimento_servicos", "agenda_movimentacoes"
  add_foreign_key "movimento_servicos", "clientes"
  add_foreign_key "movimento_servicos", "convenios"
  add_foreign_key "operadoras", "empresas"
  add_foreign_key "profissionais", "cargos"
  add_foreign_key "profissionais", "cidades"
  add_foreign_key "profissionais", "conselho_regionais"
  add_foreign_key "profissionais", "empresas"
  add_foreign_key "profissionais", "estados"
  add_foreign_key "profissionais", "operadoras"
  add_foreign_key "referencia_agendas", "profissionais"
  add_foreign_key "sala_esperas", "agendas"
  add_foreign_key "sala_esperas", "clientes"
  add_foreign_key "texto_livres", "servicos"
end
