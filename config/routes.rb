#-*-coding:utf-8-*-
Rails.application.routes.draw do
  resources :texto_livres
  resources :imagem_cabecs
  resources :fornecedores
  resources :cabecs
  resources :clientes
  resources :conselho_regionais

  resources :texto_livres
  resources :imagem_cabecs
  resources :fornecedores
  resources :cabecs
  resources :clientes
  resources :conselho_regionais

  get 'relatorios/new' => "configuracao_relatorios#new"
  get 'conselhos_regionais/new' => "conselho_regionais#new"

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

  post 'agenda/create', to: "painel/agendas#create"

  devise_for :usuarios,
              patch: "painel/usuarios",
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

  devise_scope :usuario do
    unauthenticated do
      root "painel/usuarios/sessions#new", to: "painel/usuarios/sessions#new", as: :main, path: 'painel/usuarios'
    end
  end

  namespace :painel do
    resources :dashboards

    resources :permissoes, except: [:show, :new] do
      get 'excluir'
    end

    resources :empresas do
      put 'change_name'
      get 'new_admin', to: "dashboards#new_company_admin", as: :novo_admin
      post 'create_admin', to: "dashboards#create_admin", as: :create_admin
      delete 'remove_administrador/:usuario_id', to: "dashboards#remove_admin", as: :remove_admin
      delete 'remover_permissao_empresa_usaurio/:permissao_id', to: "dashboards#remover_permissao_empresa_usaurio", as: :remover_permissao_empresa_usaurio
      resources :contas, controller: 'usuarios/accounts'
      resources :painel_usuarios, controller: 'usuarios/manager', except: [:index] do
        get  'add_permissions'
        post 'save_permissions'
      end
      resources :agendas do
        collection do
          match 'advanced_search' => 'agendas#advanced_search', via: [:get, :post], as: :advanced_search
        end
        resources :agenda_movimentacoes
        get 'movimentar', to: 'agenda_movimentacoes#verify', as: :movimentar_ou_atualizar
      end
    end

    get 'usuario/:id/permissoes', to: "usuarios/accounts#show_permissions", as: :show_user_permissions
    get 'usuario/:id/password_change', to: "usuarios/accounts#change_password", as: :change_user_password
    post '/dashboards/empresas/permissoes/create', to: "dashboards#import_permissoes_to_company", as: :dashboards_add_permissoes_to_company 
    put '/usuarios/:id/update_password', to: "usuarios/manager#update_password", as: :usuario_update_password
  end

  root to: "pages#index"
end