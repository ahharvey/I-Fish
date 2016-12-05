require "rails_helper"

RSpec.describe Memberships::FishesController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fisheries/1/memberships/fishes").to_not be_routable
    end

    it "routes to #new" do
      expect(:get => "/fisheries/1/memberships/fishes/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/fisheries/1/memberships/fishes/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(:get => "/fisheries/1/memberships/fishes/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(:post => "/fisheries/1/memberships/fishes").to route_to("memberships/fishes#create", fishery_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fisheries/1/memberships/fishes/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fisheries/1/memberships/fishes/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/fisheries/1/memberships/fishes/1").to route_to("memberships/fishes#destroy", id: "1", fishery_id: "1")
    end

  end
  describe :helpers do
    I18n.available_locales.each do |locale|
      it { expect(fishery_add_fish_path(1, locale: locale)).to eq("/#{locale}/fisheries/1/memberships/fishes") }
      it { expect(fishery_remove_fish_path(1, 1, locale: locale)).to eq("/#{locale}/fisheries/1/memberships/fishes/1") }
    end
  end
end
