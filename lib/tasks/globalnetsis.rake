require 'yaml'
require 'globalnetsis'

namespace :globalnetsis do
  desc "import globalnetsis admin to database"
  task make_admin: :environment do
    Painel::Master.create(email: "globalnetsis@globalnetsis.com.br", nome: "globalnetsis", login: "globalnetsis", password: "123456")
    puts "GLOBALNETSIS::ADMIN Importado ou atualizado"
  end

  desc "Busca e retorna admin da Globalnetsis"
  task find_master: :environment do
    unless File.exists? "tmp/painel/globalnetsis.yml"
      admin = Painel::Master.first
      data = Globalnetsis.new({
        nome: admin.nome,
        email: admin.email,
        login: admin.login,
        url: '/painel/masters/sign_in'
      })
      File.open("tmp/painel/globalnetsis_credentials.yml", "w") do |f|
        f.write YAML::dump data
      end
    else
      puts "O arquivo tmp/painel/globalnetsis_credentials.yml já existe, não será criado um novo"
      puts "Use globalnetsis:remove_credentials"
    end
  end

  desc "Remove arquivo temporario do administrador do painel Globalnetsis"
  task remove_credentials: :environment do
    if File.exists? "tmp/painel/globalnetsis_credentials.yml"
      FileUtils.rm_r "tmp/painel/globalnetsis_credentials.yml"
    end
  end

  desc "import permissions to database"
  task make_permissions: :environment do
    Painel::Permissao.create(nome: "Cargos", model_class: "Cargo")
    Painel::Permissao.create(nome: "Centro De Custos", model_class: "CentroDeCusto")
    Painel::Permissao.create(nome: "Convênios", model_class: "Convenio")
    Painel::Permissao.create(nome: "Profissionais", model_class: "Profissional")
    Painel::Permissao.create(nome: "Relatórios",model_class: "ConfiguracaoRelatorio")
    Painel::Permissao.create(nome: "Operadoras", model_class: "Operadora")
    Painel::Permissao.create(nome: "Conselhos Regionais", model_class: "ConselhoRegional")
    Painel::Permissao.create(nome: "Clientes", model_class: "Cliente")
    Painel::Permissao.create(nome: "Fornecedores", model_class: "Fornecedor")
    Painel::Permissao.create(nome: "Cabecs", model_class: "Cabec")
    Painel::Permissao.create(nome: "Imagem Cabecs", model_class: "ImagemCabec")
  end
end
