#-*-coding:utf-8-*-
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :referencia_agendas, except: [:show]

  resources :empresas do
    resources :servicos
  end

  resources :texto_livres do
    member do
      get 'show_texto_livre'
    end
  end

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
  resources :atendimentos
  resources :operadoras

  post 'agenda/paciente/change', to: "clientes#change_or_create_new_paciente", as: :change_or_create_new_paciente

  get 'ficha_cliente', to: "clientes#ficha", as: :new_ficha_cliente

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

  resources :texto_livres
  resources :imagem_cabecs
  resources :fornecedores
  resources :cabecs
  resources :conselho_regionais

  get 'relatorios/new' => "configuracao_relatorios#new"
  get 'conselhos_regionais/new' => "conselho_regionais#new"

  resources :clientes
  post 'clientes/retorna_historico', to: "clientes#retorna_historico"
  post 'clientes/salva_historico', to: "clientes#salva_historico"
  post 'clientes/atualiza_historico', to: "clientes#atualiza_historico"

  get 'pages/help'
  get 'pages/contact_us'
  get 'search/buscar_pacientes' => "search#buscar_pacientes"
  get 'search/conselho_regional', to: 'conselho_regionais#search'

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
          match 'search' => 'agendas#search', via: [:get], as: :search
          match 'search-referencia/:referencia_agenda_id'=> 'agendas#search_agenda_medicos', via: [:get], as: :search_agenda_medicos
          match 'search-referencia-proximo-dia/:referencia_agenda_id'=> 'agendas#search_agenda_medicos_outro_dia', via: [:get], as: :search_agenda_medicos_outro_dia
          match 'load_more_data' => 'agendas#load_more_data', via: [:post], as: :load_more_data
        end
        get 'clean'
        get 'didnt_came'
        get 'change_day_or_time'
        put 'change'
        get 'remark_by_pacient'
        put 'remarked_by_pacient'
        get 'remark_by_doctor'
        put 'remarked_by_doctor'
        get 'unmarked_by_doctor'
        get 'unmarked_by_pacient'
        get 'make_appointment'
        put 'attended'
        get 'block_day', to: 'agendas#block_day', as: :block_day
        put 'block_day', to: 'agendas#set_block_on_day', as: :set_block_on_day
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