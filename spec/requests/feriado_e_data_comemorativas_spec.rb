require 'rails_helper'

RSpec.describe "FeriadoEDataComemorativas", type: :request do
  describe "GET /feriado_e_data_comemorativas" do
    it "works! (now write some real specs)" do
      get feriado_e_data_comemorativas_path
      expect(response).to have_http_status(200)
    end
  end
end
