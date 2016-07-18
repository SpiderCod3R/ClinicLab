class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Usuario.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :manage, :to => :crud

    if user.super?
      can :crud, :all
    elsif user.admin?
      if can :read, Empresa do |e|
          e.try(:id).eql?(user.empresa_id)
        end
      end

      can :manage, Usuario

      user.empresa.try(:empresa_permissao_empresas).each do |f|
        if f.try(:empresa_id).eql?(user.empresa_id)
          user.empresa.try(:permissao_empresas).each do |p|
            can :crud, p.modulo.constantize
          end
        end
      end
    elsif user.funcionario?
      if can :read, Empresa do |e|
          e.try(:id).eql?(user.empresa_id)
        end
      end
      can :read, Usuario

      user.empresa.try(:empresa_permissao_empresas).each do |f|
        if f.try(:empresa_id).eql?(user.empresa_id)
          user.try(:usuario_permissao_empresas).each do |p|
            can :create,  p.permissao_empresa.modulo.constantize if p.cadastrar?
            can :update,  p.permissao_empresa.modulo.constantize if p.editar?
            can :read,    p.permissao_empresa.modulo.constantize if p.visualizar?
            can :destroy, p.permissao_empresa.modulo.constantize if p.excluir?
          end
        end
      end
    end
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
