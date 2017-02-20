require "rails_helper"

RSpec.describe ReceituariosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/receituarios").to route_to("receituarios#index")
    end

    it "routes to #new" do
      expect(:get => "/receituarios/new").to route_to("receituarios#new")
    end

    it "routes to #show" do
      expect(:get => "/receituarios/1").to route_to("receituarios#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/receituarios/1/edit").to route_to("receituarios#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/receituarios").to route_to("receituarios#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/receituarios/1").to route_to("receituarios#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/receituarios/1").to route_to("receituarios#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/receituarios/1").to route_to("receituarios#destroy", :id => "1")
    end

  end
end
