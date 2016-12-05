require "rails_helper"

RSpec.describe Memberships::VesselsController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fisheries/1/memberships/vessels").to_not be_routable
    end

    it "routes to #new" do
      expect(:get => "/fisheries/1/memberships/vessels/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/fisheries/1/memberships/vessels/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(:get => "/fisheries/1/memberships/vessels/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(:post => "/fisheries/1/memberships/vessels").to route_to("memberships/vessels#create", fishery_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fisheries/1/memberships/vessels/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fisheries/1/memberships/vessels/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/fisheries/1/memberships/vessels/1").to route_to("memberships/vessels#destroy", id: "1", fishery_id: "1")
    end

  end
  describe :helpers do
    I18n.available_locales.each do |locale|
      it { expect(fishery_add_vessel_path(1, locale: locale)).to eq("/#{locale}/fisheries/1/memberships/vessels") }
      it { expect(fishery_remove_vessel_path(1, 1, locale: locale)).to eq("/#{locale}/fisheries/1/memberships/vessels/1") }
    end
  end
end
