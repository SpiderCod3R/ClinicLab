require 'rails_helper'

RSpec.describe "Receituarios", type: :request do
  describe "GET /receituarios" do
    it "works! (now write some real specs)" do
      get receituarios_path
      expect(response).to have_http_status(200)
    end
  end
end
