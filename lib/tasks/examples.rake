# require_relative 'painel/globalnetsis.rb'

# namespace :samples do
#   desc "Creating a company sample"
#   task company: :environment do
#     Painel::Empresa.create(nome: "Ruby Hospital Center", status: true, slug: "ruby-hospital-center")
#     puts "Sample Company created with success"
#   end

#   desc "Creating admin to sample company"
#   task company_admin: :environment do
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id
#     Painel::Usuario.create(email: "admin@rubyhospitalcenter.com", nome: "admin", login: "admin", password: "admin2016", empresa_id: @empresa_id, admin: true)
#     puts "Sample Company Admin created with success"
#   end

#   desc "import permissions to sample company"
#   task company_modules: :environment do
#     @modulos = Painel::Permissao.all
#     unless @modulos.empty?
#       @empresa = Painel::Empresa.find_by("nome LIKE '%Ruby%'")
#       @modulos.each do |permissao|
#         @empresa.empresa_permissoes.create(permissao_id: permissao.id)
#       end
#       puts "Sample Company Admin created with success"
#     else
#       print "There is no Module found on database"
#       puts  "Please run globalnetsis:make_permissions"
#     end
#   end

#   desc "Creating a cargos sample"
#   task cargos: :environment do
#     cargos = ['Cirurgião Plástico', 'Dermatologista', 'Pediatra', 'Oftaumologista', 'Neurologista', 'Psicologo']
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id
    
#     for i in 0..cargos.size
#       Cargo.create(nome: cargos[i], status: 1, empresa_id: @empresa_id)
#     end
#     puts "Sample Cargos created with success"
#   end

#   desc "Creating a cargos sample"
#   task convenio: :environment do
#     convenios = ['AMIL', 'UNIMED', 'INTERMEDICA']
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id

#     (0..convenios.size).each do |i|
#       Convenio.create(nome: convenios[i], status: 1, empresa_id: @empresa_id, valor: Faker::Number.decimal(3))
#     end
#     puts "Sample Convenios created with success"
#   end

#   desc "Creating a conselho regional sample"
#   task conselho_regional: :environment do
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id
#     ConselhoRegional.create(sigla: "CREMERJ", descricao: Faker::Hipster.paragraph, status: 1, empresa_id: @empresa_id)
#     puts "Sample Conselho Regional created with success"
#   end

#   desc "Creating a operadora sample"
#   task operadora: :environment do
#     operadoras = ['VII', 'VIII', 'IX', 'X']
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id
#     for i in 0..operadoras.size
#       Operadora.create(nome: operadoras[i], status: 1, empresa_id: @empresa_id)
#     end
#     puts "Sample operadora created with success"
#   end

#   desc "Creating a profissional sample"
#   task profissional: :environment do
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id
#     profissionais = { 
#                       profissional: {
#                         "0": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "893.288.555-94", rg: "24.754.874-1", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 1, estado_id: 19, cidade_id: 3624, data_nascimento: "1989-09-07", cargo_id: 1, conselho_regional_id: 1},
#                         "1": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "392.860.713-88", rg: "35.275.372-9", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 2, estado_id: 19, cidade_id: 3630, data_nascimento: "1989-09-07", cargo_id: 2, conselho_regional_id: 1},
#                         "2": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "013.331.261-58", rg: "15.264.035-6", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 3, estado_id: 19, cidade_id: 3652, data_nascimento: "1989-09-07", cargo_id: 3, conselho_regional_id: 1},
#                         "3": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "310.773.813-10", rg: "33.901.207-9", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 2, estado_id: 19, cidade_id: 3652, data_nascimento: "1989-09-07", cargo_id: 4, conselho_regional_id: 1},
#                         "4": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "074.154.247-19", rg: "14.235.731-5", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 3, estado_id: 19, cidade_id: 3652, data_nascimento: "1989-09-07", cargo_id: 5, conselho_regional_id: 1},
#                         "5": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "234.485.664-11", rg: "13.102.553-3", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 4, estado_id: 19, cidade_id: 3624, data_nascimento: "1989-09-07", cargo_id: 6, conselho_regional_id: 1},
#                         "6": {nome: Faker::Name.name_with_middle, telefone: Faker::PhoneNumber.phone_number, celular: Faker::PhoneNumber.cell_phone, cpf: "857.312.193-97", rg: "44.986.498-4", status: 1, endereco: Faker::Address.street_address, bairro: Faker::Address.street_name, complemento: "Algum", operadora_id: 4, estado_id: 19, cidade_id: 3624, data_nascimento: "1989-09-07", cargo_id: 1, conselho_regional_id: 1}
#                       }
#                     }
#     i = 0
#     while i <= profissionais[:profissional].size do
#       if i == profissionais[:profissional].size
#         break
#       else
#         Profissional.create(nome: profissionais[:profissional][:"#{i}"][:nome],
#                              telefone: profissionais[:profissional][:"#{i}"][:telefone], 
#                              celular: profissionais[:profissional][:"#{i}"][:celular],
#                              cpf: profissionais[:profissional][:"#{i}"][:cpf],
#                              rg: profissionais[:profissional][:"#{i}"][:rg],
#                              status: profissionais[:profissional][:"#{i}"][:status],
#                              endereco: profissionais[:profissional][:"#{i}"][:endereco],
#                              bairro: profissionais[:profissional][:"#{i}"][:bairro],
#                              complemento: profissionais[:profissional][:"#{i}"][:complemento],
#                              operadora_id: profissionais[:profissional][:"#{i}"][:operadora_id],
#                              estado_id: profissionais[:profissional][:"#{i}"][:estado_id],
#                              cidade_id: profissionais[:profissional][:"#{i}"][:cidade_id],
#                              data_nascimento: profissionais[:profissional][:"#{i}"][:data_nascimento],
#                              cargo_id: profissionais[:profissional][:"#{i}"][:cargo_id],
#                              conselho_regional_id: profissionais[:profissional][:"#{i}"][:conselho_regional_id],
#                              empresa_id: @empresa_id)
#       end
#       i += 1
#     end
#     puts "Sample profissionals created with success"
#   end

#   desc "Creating a Cliente sample"
#   task cliente: :environment do
#     @empresa_id = Painel::Empresa.find_by("nome LIKE '%Ruby%'").id
#     cpfs = ["893.288.555-94", "392.860.713-88", "013.331.261-58", "310.773.813-10", "074.154.247-19", "234.485.664-11", "857.312.193-97"]
#     rgs  = ["24.754.874-1", "35.275.372-9", "15.264.035-6", "33.901.207-9", "14.235.731-5", "13.102.553-3", "44.986.498-4"]
#     sexos= ["Masculino", "Feminino", "Masculino", "Masculino", "Feminino", "Feminino", "Feminino"]
#     7.times do |i|
#       Cliente.create!(nome:    Faker::Name.name_with_middle,
#                      telefone: Faker::PhoneNumber.phone_number, 
#                      email: Faker::Internet.safe_email,
#                      cpf: cpfs[i],
#                      rg: rgs[i],
#                      status: true,
#                      estado_id: 19,
#                      cidade_id: 3652,
#                      endereco: Faker::Address.street_address,
#                      bairro: Faker::Address.street_name,
#                      complemento: "Algum",
#                      sexo: sexos[i],
#                      estado_civil: "solteiro",
#                      nascimento: Faker::Date.between(10000.days.ago, Date.today),
#                      matricula: Faker::Code.asin,
#                      validade_carteira: Faker::Date.between(365.days.ago, Date.today),
#                      convenio_id: 1,
#                      status_convenio: "Ativo",
#                      plano: "A",
#                      empresa_id: @empresa_id,
#                      cargo_id: 1,
#                      produto: "X",
#                      titular: "A mãe",
#                      status: 1)
#     end
#     puts "Sample clientes created with success"
#   end
# end