Rails.application.routes.draw do

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

  devise_for :usuarios, controller: { registrations: 'authentication/registrations', sessions: 'authentication/sessions' }

  devise_scope :usuario do
   get "login", to: "devise/sessions#new", as: :login_screen
   post "login", to: "authentication/sessions#create"
  end

  authenticated :usuario do
    devise_scope :usuario do
      root to: "authentication/registrations#show", as: "profile"
    end
  end

  unauthenticated do
    devise_scope :user do
      root to: "pages#home", :as => "home"
    end
  end

  resources :empresas, controller: 'empresas/empresas' do
    resources :usuarios, controller: 'empresas/usuarios'
    resources :funcionarios, controller: 'empresas/funcionarios'
    get 'usuarios/trocar_senha/:id'=> 'empresas/usuarios#change_password', as: :trocar_senha_usuario
    put 'usuarios/trocar_senha/:id'=> 'empresas/usuarios#change_user_password', as: :update_usuario_password
    get 'usuarios/atualiza_permissoes/usuario/:id', to: 'empresas/usuarios#update_permissions', as: :usuario_atualiza_permissoes
    put 'usuarios/atualiza_permissoes/', to: 'empresas/usuarios#update', as: :atualiza_permissoes_modulo
    get 'relatorios/atendimentos/paciente/:atendimento_id', to: "reports#relatorio_atendimento", as: :atendimento_paciente_relatorio
  end

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
