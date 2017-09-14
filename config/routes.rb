  #-*-coding:utf-8-*-
Rails.application.routes.draw do
  resources :exames
  mount Ckeditor::Engine => '/ckeditor'
  namespace :painel do
    resources :environments do
      member do
        get 'edit_environment_admin_account'
        put 'update_environment_admin_account'
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
    resources :feriado_e_data_comemorativas
    resources :imagens_externas
    get 'ficha_cliente', to: "clientes#clinic_sheet", as: :clinic_sheet_cliente
    resources :clientes do
      member do
        get    'print_free_text'
        get    'print_historico'
        get    'print_historico_full'
        get    'print_recipe'
        get    'paginate_pdfs'
        get    'find_recipe'
        delete 'destroy_pdf'
        get    'search_pdf_remotely'
        get    'change_convenio'
      end
      put 'atualizar_convenio', to: "cliente_convenios#update_convenio", as: :update_convenio
      get 'inativar_convenio', to: "cliente_convenios#deactivate", as: :deactivate_convenio
      get 'ativar_convenio', to: "cliente_convenios#activate", as: :activate_convenio
    end
    resources :cabecs
    resources :cargos
    resources :centro_de_custos
    resources :configuracao_relatorios
    resources :conselho_regionais
    resources :convenios, except: [:show]
    resources :exame_procedimentos
    resources :fornecedores
    resources :imagem_cabecs, except: [:show]
    resources :movimento_servico_servicos
    resources :movimento_servicos do
      get 'add_servicos', to: "movimento_servicos#add_servicos", as: :add_servicos
      get 'edit_servicos', to: "movimento_servicos#edit_servicos", as: :edit_servicos
      get 'destroy_movimento_servico_servico', to: "movimento_servicos#destroy_movimento_servico_servico", as: :destroy_servico
    end
    resources :operadoras
    resources :profissionais
    resources :receituarios
    resources :referencia_agendas, except: [:show]
    resources :servicos
    resources :texto_livres
    resources :contas, controller: 'painel/usuarios/accounts' do
      member do
        put 'change_account'
      end
    end
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
      get 'get_convenio', to: 'sala_de_espera#get_convenio', as: :get_convenio
      resources :agenda_movimentacoes
      resources :sala_de_espera do
        collection do
          get 'search', to: 'sala_de_espera#localize', as: :localize, via: [:get]
        end
        member do
          get 'back'
          get 'attended'
          get 'get_convenio'
        end
      end
      get 'movimentar', to: 'agenda_movimentacoes#new', as: :movimentar_ou_atualizar
    end
    get 'receita/:recipe_id/remove', to: "clientes#destroy_cliente_receituario"

    get 'usuario/:id/permissoes', to: "painel/usuarios/accounts#show_permissions", as: :show_user_permissions
  end

  resources :atendimentos

  get 'relatorios/new' , to: "configuracao_relatorios#new"
  get 'conselhos_regionais/new' , to: "conselho_regionais#new"
  post 'agendas/clientes/new', to: "clientes#change_or_create_cliente", as: :change_or_create_cliente
  put  'agendas/clientes/update_cliente', to: "clientes#update_cliente", as: :update_cliente
  post 'clientes/retorna_historico', to: "clientes#retorna_historico"
  post 'clientes/salva_historico', to: "clientes#salva_historico"
  post 'clientes/atualiza_historico', to: "clientes#atualiza_historico"
  post 'clientes/salva_cliente_convenios', to: "clientes#salva_cliente_convenios"
  post 'clientes/cria_session_cliente_convenios', to: "clientes#cria_session_cliente_convenios"
  get 'clientes/:id/destroy_cliente_convenio', to: "clientes#destroy_cliente_convenio", as: :destroy_cliente_convenio
  get  'clientes/:cliente_id/destroy_texto_livre', to: "clientes#destroy_cliente_texto_livre"
  get 'clientes/:cliente_id/textos_livres', to: "clientes#find_textos_livre", as: :cliente_find_textos_livres
  get 'relatorios/new' , to: "configuracao_relatorios#new"
  get 'conselhos_regionais/new' , to: "conselho_regionais#new"
  get 'search/conselho_regional', to: 'conselho_regionais#search'
  get 'search/collect_clientes', to: "search#collect_clientes"
  get 'search/find_cliente' , to: "search#find_cliente"
  get 'search/find-texto-livres', to: "search#collect_all_free_text" ,as: :collect_all_free_text
  get 'search/conselho_regional', to: 'conselho_regionais#search'
  get 'search/find_cliente_convenio', to: 'search#find_cliente_convenio'
  get 'search/cliente-texto-livre', to: 'search#find_cliente_texto_livre'
  post 'movimento_servicos/salva_movimento_servico_servicos', to: "movimento_servicos#salva_movimento_servico_servicos"
  post 'movimento_servicos/retorna_servico', to: "movimento_servicos#retorna_servico"
  post 'movimento_servicos/prosseguir_servicos', to: "movimento_servicos#prosseguir_servicos", as: :prosseguir_servicos

  post 'clientes/include_texto_livre', to: 'clientes#include_texto_livre'
  post 'clientes/include_recipe', to: 'clientes#include_recipe'
  get 'search/receituario', to: 'search#find_receituario'
  get 'search/texto_livre', to: 'search#find_texto_livre'
  get 'search/cliente_receituario', to: 'search#find_cliente_receituario'

  namespace :painel do
    resources :dashboards
    post '/dashboards/empresas/permissoes/create', to: "dashboards#import_permissoes_to_company", as: :dashboards_add_permissoes_to_company
  end

  get 'pages/help'
  get 'pages/contact_us'
  get 'pages/index'

  root to: "pages#index"
end
