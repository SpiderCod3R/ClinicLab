class Painel::DashboardsController < ApplicationController
  before_action :authenticate_master!
  layout 'admin'

  def index
  end
end
