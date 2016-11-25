require "rails_helper"

RSpec.describe FishesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fishes").to route_to("fishes#index")
    end

    it "routes to #new" do
      expect(:get => "/fishes/new").to route_to("fishes#new")
    end

    it "routes to #show" do
      expect(:get => "/fishes/1").to route_to("fishes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fishes/1/edit").to route_to("fishes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fishes").to route_to("fishes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fishes/1").to route_to("fishes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fishes/1").to route_to("fishes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fishes/1").to route_to("fishes#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(fishes_path).to eq("/fishes") }
    it { expect(new_fish_path).to eq("/fishes/new") }

    I18n.available_locales.each do |locale|
      it { expect(fish_path(1, locale: locale)).to eq("/#{locale}/fishes/1") }
      it { expect(edit_fish_path(1, locale: locale)).to eq("/#{locale}/fishes/1/edit") }
    end
  end
end
