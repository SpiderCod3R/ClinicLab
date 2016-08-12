class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Painel::Usuario.new

    if can :read, Painel::Empresa do |e|
        e.try(:id).eql?(user.empresa_id)
      end
    end

    if user.admin?
      can :manage, Painel::Usuario

      user.empresa.try(:empresa_permissoes).each do |f|
        if f.try(:empresa_id).eql?(user.empresa_id)
          user.empresa.try(:permissoes).each do |p|
            can :manage, p.model_class.constantize
          end
        end
      end
    elsif user.funcionario?
      user.empresa.try(:empresa_permissoes).each do |f|
        if f.try(:empresa_id).eql?(user.empresa_id)
          user.try(:usuario_permissoes).each do |p|
            can :create,  p.permissao_empresa.model_class.constantize if p.cadastrar?
            can :update,  p.permissao_empresa.model_class.constantize if p.atualizar?
            can :read,    p.permissao_empresa.model_class.constantize if p.exibir?
            can :destroy, p.permissao_empresa.model_class.constantize if p.deletar?
          end
        end
      end
    end
  end
end
