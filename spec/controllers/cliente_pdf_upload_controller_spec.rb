require 'rails_helper'

RSpec.describe ClientePdfUploadController, type: :controller do

  describe "GET #send" do
    it "returns http success" do
      get :send
      expect(response).to have_http_status(:success)
    end
  end

end
