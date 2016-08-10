Rails.application.routes.draw do
  namespace :painel do
    resources :dashboards
    resources :permissoes, except: [:show, :new] do
      get 'excluir'
    end
    resources :empresas do
      resources :painel_usuarios, controller: 'usuarios/manager', except: [:index]
    end
    post '/dashboards/empresas/permissoes/create', to: "dashboards#import_permissoes_to_company", as: :dashboards_add_permissoes_to_company 
    put '/usuarios/:id/update_password', to: "usuarios/manager#update_password", as: :usuario_update_password
  end

  devise_for :usuarios,
              path: 'painel/usuarios',
              class_name: "Painel::Usuario",
              controllers: { sessions: 'painel/usuarios/sessions' }

  devise_for :masters, 
             path: 'painel/masters',
             class_name: "Painel::Master",
             controllers: { sessions: 'painel/masters/sessions' },
             skip: [:registrations]

  authenticated :master do
    root 'painel/dashboards#index', as: "authenticated_master_root"
  end

  authenticated :usuario do
    root 'painel/dashboards#index', as: "authenticated_usuario_root"
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