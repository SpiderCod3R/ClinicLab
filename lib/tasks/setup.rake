require 'yaml'
require_relative 'painel/globalnetsis.rb'

namespace :setup do
  desc "import globalnetsis admin to database"
  task :create_admin do
    puts "-*- SENDING ADMIN -*-"
    Gclinic::Admin.create(email: "globalnetsis@globalnetsis.com.br", name: "globalnetsis", password: "#GSUPER4582?")
  end

  desc "import models to database"
  task :send_models do
    puts "-*- SENDING MODELS -*-"
    Gclinic::Model.create(name: "Agendas", model_class: "Agenda")
    Gclinic::Model.create(name: "Atendimentos", model_class: "Atendimento")
    Gclinic::Model.create(name: "Clientes", model_class: "Cliente")
    Gclinic::Model.create(name: "Cabecs", model_class: "Cabec")
    Gclinic::Model.create(name: "Cargos", model_class: "Cargo")
    Gclinic::Model.create(name: "Centro de Custos", model_class: "CentroDeCusto")
    Gclinic::Model.create(name: "Configuração de Relatório", model_class: "ConfiguracaoRelatorio")
    Gclinic::Model.create(name: "Conselhos Regionais", model_class: "ConselhoRegional")
    Gclinic::Model.create(name: "Convênios", model_class: "Convenio")
    Gclinic::Model.create(name: "Fornecedores", model_class: "Fornecedor")
    Gclinic::Model.create(name: "Imagem Cabecs", model_class: "ImagemCabec")
    Gclinic::Model.create(name: "Operadoras", model_class: "Operadora")
    Gclinic::Model.create(name: "Profissionais", model_class: "Profissional")
    Gclinic::Model.create(name: "Referência Agendas", model_class: "ReferenciaAgenda")
    Gclinic::Model.create(name: "Serviços", model_class: "Servico")
    Gclinic::Model.create(name: "Textos Livre", model_class: "TextoLivre")
    puts "-*- ALL DATA CONTAINED ON db/seed.rb SUCCESSFULLY IMPORTED -*-"
  end
end
