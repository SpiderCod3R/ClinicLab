class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Gclinic::User.new

    if can :read, Empresa do |e|
        e.try(:id).eql?(user.empresa_id)
      end
    end

    if user.admin?
      can :manage, Gclinic::User

      user.environment.try(:environment_models).each do |f|
        if f.try(:environment_id).eql?(user.environment_id)
          user.environment.try(:models).each do |p|
            can :manage, p.model_class.constantize
          end
        end
      end
    elsif user.employee?
      user.environment.try(:environment_models).each do |f|
        if f.try(:environment_id).eql?(user.environment_id)
          user.try(:user_models).each do |p|
            can :create,  p.model.model_class.constantize if p.cadastrar?
            can :update,  p.model.model_class.constantize if p.atualizar?
            can :read,    p.model.model_class.constantize if p.exibir?
            can :destroy, p.model.model_class.constantize if p.deletar?
          end
        end
      end
    end
  end
end
