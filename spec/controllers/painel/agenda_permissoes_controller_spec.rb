require 'rails_helper'

RSpec.describe Painel::AgendaPermissoesController, type: :controller do

  describe "GET #permissions" do
    it "returns http success" do
      get :permissions
      expect(response).to have_http_status(:success)
    end
  end

end
