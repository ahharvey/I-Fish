require "rails_helper"

RSpec.describe LandingsController, type: :routing do
  describe "nested" do
    it "routes to companies/importers#new" do
      expect(:get => "/companies/1/importers/new").to route_to("importers#new", company_id: "1")
    end
    it "routes to companies/importers#create" do
      expect(:post => "/companies/1/importers").to route_to("importers#create", company_id: "1")
    end
    it "routes to vessels/importers#new" do
      expect(:get => "/vessels/1/importers/new").to route_to("importers#new", vessel_id: "1")
    end
    it "routes to vessels/importers#create" do
      expect(:post => "/vessels/1/importers").to route_to("importers#create", vessel_id: "1")
    end
  end

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/importers").to route_to("importers#index")
    end

    it "routes to #new" do
      expect(:get => "/importers/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/importers/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(:get => "/importers/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(:post => "/importers").to_not be_routable
    end

    it "routes to #update via PUT" do
      expect(:put => "/importers/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/importers/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/importers/1").to_not be_routable
    end

  end
  describe :helpers do
    it { expect(importers_path).to eq("/importers") }
    I18n.available_locales.each do |locale|
      it { expect(new_company_importer_path(1, locale: locale)).to eq("/#{locale}/companies/1/importers/new") }
      it { expect(new_vessel_importer_path(1, locale: locale)).to eq("/#{locale}/vessels/1/importers/new") }
    end
  end
end
