class PagesController < ApplicationController
  before_action :authenticate_usuario!

  def index
  end

  def help
    #TODO
  end

  def contact_us
    #TODO
  end
end
