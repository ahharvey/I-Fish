require "rails_helper"

RSpec.describe LandingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/landings").to route_to("landings#index")
    end

    it "routes to #new" do
      expect(:get => "/landings/new").to route_to("landings#new")
    end

    it "routes to #show" do
      expect(:get => "/landings/1").to route_to("landings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/landings/1/edit").to route_to("landings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/landings").to route_to("landings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/landings/1").to route_to("landings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/landings/1").to route_to("landings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/landings/1").to route_to("landings#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(landings_path).to eq("/landings") }
    it { expect(new_landing_path).to eq("/landings/new") }

    I18n.available_locales.each do |locale|
      it { expect(landing_path(1, locale: locale)).to eq("/#{locale}/landings/1") }
      it { expect(edit_landing_path(1, locale: locale)).to eq("/#{locale}/landings/1/edit") }
    end
  end
end
