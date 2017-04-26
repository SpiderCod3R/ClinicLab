require "rails_helper"

RSpec.describe FeriadoEDataComemorativasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/feriado_e_data_comemorativas").to route_to("feriado_e_data_comemorativas#index")
    end

    it "routes to #new" do
      expect(:get => "/feriado_e_data_comemorativas/new").to route_to("feriado_e_data_comemorativas#new")
    end

    it "routes to #show" do
      expect(:get => "/feriado_e_data_comemorativas/1").to route_to("feriado_e_data_comemorativas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/feriado_e_data_comemorativas/1/edit").to route_to("feriado_e_data_comemorativas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/feriado_e_data_comemorativas").to route_to("feriado_e_data_comemorativas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/feriado_e_data_comemorativas/1").to route_to("feriado_e_data_comemorativas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/feriado_e_data_comemorativas/1").to route_to("feriado_e_data_comemorativas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/feriado_e_data_comemorativas/1").to route_to("feriado_e_data_comemorativas#destroy", :id => "1")
    end

  end
end
