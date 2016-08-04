Rails.application.routes.draw do
  devise_for :masters, class_name: "Painel::Master"
  namespace :painel do
    get 'masters/index'
    resources :permissoes
    resources :empresas
  end

  resources :permissaos
  resources :texto_livres
  resources :imagem_cabecs
  resources :fornecedores
  resources :cabecs
  resources :clientes
  resources :conselho_regionais

  get 'pages/help'
  get 'pages/contact_us'
  get 'search/buscar_pacientes' => "search#buscar_pacientes"
  get 'search/conselho_regional', to: 'conselho_regionais#search'

  resources :configuracao_relatorios
  resources :centro_de_custos
  resources :profissionais
  resources :cargos
  resources :convenios
  resources :pacientes
  resources :atendimentos
  resources :operadoras

  root to: "pages#home"
end