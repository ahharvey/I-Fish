require "rails_helper"

RSpec.describe FisheriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fisheries").to route_to("fisheries#index")
    end

    it "routes to #new" do
      expect(:get => "/fisheries/new").to route_to("fisheries#new")
    end

    it "routes to #show" do
      expect(:get => "/fisheries/1").to route_to("fisheries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fisheries/1/edit").to route_to("fisheries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fisheries").to route_to("fisheries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fisheries/1").to route_to("fisheries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fisheries/1").to route_to("fisheries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fisheries/1").to route_to("fisheries#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(fisheries_path).to eq("/fisheries") }
    it { expect(new_fishery_path).to eq("/fisheries/new") }

    I18n.available_locales.each do |locale|
      it { expect(fishery_path(1, locale: locale)).to eq("/#{locale}/fisheries/1") }
      it { expect(edit_fishery_path(1, locale: locale)).to eq("/#{locale}/fisheries/1/edit") }
    end
  end
end
