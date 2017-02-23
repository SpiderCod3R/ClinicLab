  #-*-coding:utf-8-*-
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  namespace :painel do
    resources :environments do
      member do
        get 'remove_model'
      end
    end
    resources :models, except: [:show, :new]
  end

  devise_for :admins, class_name: "Gclinic::Admin",
                      patch: "gclinic/admins",
                      controllers: { sessions: 'painel/admins/sessions' }

  devise_for :users, class_name: "Gclinic::User",
                     patch: "painel/usuarios",
                     controllers: { sessions: 'painel/usuarios/sessions' }

  devise_scope :user do
    unauthenticated do
      root "painel/usuarios/sessions#new", to: "painel/usuarios/sessions#new", as: :main, path: 'painel/usuarios'
    end
  end

  authenticated :admin do
    root 'painel/dashboards#index', as: "authenticated_admin_root"
  end

  resources :texto_livres do
    member do
      get 'show_texto_livre'
    end
  end

  resources :empresa do
    get 'ficha_cliente', to: "clientes#clinic_sheet", as: :clinic_sheet_cliente
    resources :clientes do
      member do
        get    'print_free_text'
        get    'print_historico'
        get    'print_historico_full'
        get    'paginate_pdfs'
        delete 'destroy_pdf'
      end
    end
    resources :configuracao_relatorios
    resources :conselho_regionais
    resources :convenios, except: [:show]
    resources :cargos
    resources :cabecs
    resources :centro_de_custos
    resources :imagem_cabecs, except: [:show]
    resources :operadoras
    resources :profissionais
    resources :fornecedores
    resources :servicos
    resources :receituarios
    resources :texto_livres
    resources :referencia_agendas, except: [:show]
    resources :contas, controller: 'painel/usuarios/accounts'
    resources :usuarios, controller: 'painel/usuarios/manager', except: [:index] do
      get  'add_permissions'
      post 'save_permissions'
      member do
        get 'change_account'
        put 'change_data'
      end
    end
    resources :agenda_permissoes, controller: "painel/agenda_permissoes", except: [:index, :show, :new, :create, :edit, :update, :destroy] do
      member do
        get 'manager'
        post 'build_agenda_permissions'
      end
    end
    resources :cliente_permissoes, controller: "cliente_permissoes", except: [:index, :show, :new, :create, :edit, :update, :destroy] do
      member do
        get  'manager'
        post 'build_permissions'
      end
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
      get 'movimentar', to: 'agenda_movimentacoes#new', as: :movimentar_ou_atualizar
    end
  end

  resources :atendimentos

  get 'relatorios/new' => "configuracao_relatorios#new"
  get 'conselhos_regionais/new' => "conselho_regionais#new"
  post 'agendas/clientes/change_or_create_paciente', to: "clientes#change_or_create_paciente", as: :create_paciente
  put  'agendas/clientes/change_or_create_paciente', to: "clientes#change_or_create_paciente", as: :change_paciente
  post 'clientes/retorna_historico', to: "clientes#retorna_historico"
  post 'clientes/salva_historico', to: "clientes#salva_historico"
  post 'clientes/atualiza_historico', to: "clientes#atualiza_historico"
  get  'clientes/:cliente_id/destroy_texto_livre', to: "clientes#destroy_cliente_texto_livre"
  get 'clientes/:cliente_id/textos_livres', to: "clientes#find_textos_livre", as: :cliente_find_textos_livres
  get 'relatorios/new' => "configuracao_relatorios#new"
  get 'conselhos_regionais/new' => "conselho_regionais#new"
  get 'search/conselho_regional', to: 'conselho_regionais#search'
  get 'search/buscar_pacientes' => "search#buscar_pacientes"
  get 'search/find-texto-livres'=> "search#collect_all_free_text" ,as: :collect_all_free_text
  get 'search/conselho_regional', to: 'conselho_regionais#search'
  get 'search/cliente-texto-livre', to: 'search#find_cliente_texto_livre'
  post 'clientes/include_texto_livre', to: 'clientes#include_texto_livre'
  post 'clientes/salva_cliente_convenios', to: "clientes#salva_cliente_convenios"
  get 'clientes/:id/destroy_cliente_convenio', to: "clientes#destroy_cliente_convenio", as: :destroy_cliente_convenio

  namespace :painel do
    resources :dashboards
    post '/dashboards/empresas/permissoes/create', to: "dashboards#import_permissoes_to_company", as: :dashboards_add_permissoes_to_company 
    # resources :empresas do
    #   put 'change_name'
    #   get 'new_admin', to: "dashboards#new_company_admin", as: :novo_admin
    #   post 'create_admin', to: "dashboards#create_admin", as: :create_admin
    #   delete 'remove_administrador/:usuario_id', to: "dashboards#remove_admin", as: :remove_admin
    #   delete 'remover_permissao_empresa_usaurio/:permissao_id', to: "dashboards#remover_permissao_empresa_usaurio", as: :remover_permissao_empresa_usaurio
    # end
  end

  get 'pages/help'
  get 'pages/contact_us'

  root to: "pages#index"
end