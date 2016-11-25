require "rails_helper"

RSpec.describe GraticulesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/graticules").to route_to("graticules#index")
    end

    it "routes to #new" do
      expect(:get => "/graticules/new").to route_to("graticules#new")
    end

    it "routes to #show" do
      expect(:get => "/graticules/1").to route_to("graticules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/graticules/1/edit").to route_to("graticules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/graticules").to route_to("graticules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/graticules/1").to route_to("graticules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/graticules/1").to route_to("graticules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/graticules/1").to route_to("graticules#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(graticules_path).to eq("/graticules") }
    it { expect(new_graticule_path).to eq("/graticules/new") }

    I18n.available_locales.each do |locale|
      it { expect(graticule_path(1, locale: locale)).to eq("/#{locale}/graticules/1") }
      it { expect(edit_graticule_path(1, locale: locale)).to eq("/#{locale}/graticules/1/edit") }
    end
  end
end
