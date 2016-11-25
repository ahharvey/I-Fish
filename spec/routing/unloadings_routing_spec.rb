require "rails_helper"

RSpec.describe UnloadingsController, type: :routing do

  describe "routing" do



    it "routes to #index" do
      expect(:get => "/unloadings").to route_to("unloadings#index")
    end

    it "routes to #new" do
      expect(:get => "/unloadings/new").to route_to("unloadings#new")
    end

    it "routes to #show" do
      expect(:get => "/unloadings/1").to route_to("unloadings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/unloadings/1/edit").to route_to("unloadings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/unloadings").to route_to("unloadings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/unloadings/1").to route_to("unloadings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/unloadings/1").to route_to("unloadings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/unloadings/1").to route_to("unloadings#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(unloadings_path).to eq("/unloadings") }
    it { expect(new_unloading_path).to eq("/unloadings/new") }

    I18n.available_locales.each do |locale|
      it { expect(unloading_path(1, locale: locale)).to eq("/#{locale}/unloadings/1") }
      it { expect(edit_unloading_path(1, locale: locale)).to eq("/#{locale}/unloadings/1/edit") }
    end
  end
end
