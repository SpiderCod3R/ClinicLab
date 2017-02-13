class Support::InsideController < ApplicationController
  before_action :authenticate_user!
  before_action :set_environment

  private
    def set_environment
      @environment = Gclinic::Environment.friendly.find(current_user.environment)
      Thread.current[:environment_type]= @environment.database_name
      session[:environment_type]= @environment.database_name
    end
end