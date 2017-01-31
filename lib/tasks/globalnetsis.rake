require 'yaml'
require_relative 'painel/globalnetsis.rb'

namespace :globalnetsis do
  desc "Import globalnetsis main admin to database"
  task make_admin: :environment do
    Gclinic::Admin.create(
                          username: "globalnetsis",
                          email:    "globalnetsis@globalnetsis.com.br",
                          password: Globalnetsis::Secret.make
                        )
    puts "GLOBALNETSIS::ADMIN Importado"
  end

  # desc "import permissions to database"
  # task make_permissions: :environment do
  #   Painel::Permissao.create(nome: "Agendas", model_class: "Agenda")
  #   Painel::Permissao.create(nome: "Referência Agendas", model_class: "ReferenciaAgenda")
  #   Painel::Permissao.create(nome: "Cargos", model_class: "Cargo")
  #   Painel::Permissao.create(nome: "Centro De Custos", model_class: "CentroDeCusto")
  #   Painel::Permissao.create(nome: "Convênios", model_class: "Convenio")
  #   Painel::Permissao.create(nome: "Profissionais", model_class: "Profissional")
  #   Painel::Permissao.create(nome: "Relatórios",model_class: "ConfiguracaoRelatorio")
  #   Painel::Permissao.create(nome: "Operadoras", model_class: "Operadora")
  #   Painel::Permissao.create(nome: "Conselhos Regionais", model_class: "ConselhoRegional")
  #   Painel::Permissao.create(nome: "Clientes", model_class: "Cliente")
  #   Painel::Permissao.create(nome: "Fornecedores", model_class: "Fornecedor")
  #   Painel::Permissao.create(nome: "Cabecs", model_class: "Cabec")
  #   Painel::Permissao.create(nome: "Imagem Cabecs", model_class: "ImagemCabec")
  # end
end
