require "rails_helper"

RSpec.describe UnloadingCatchesController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/unloading_catches").to_not be_routable
    end

    it "routes to #new" do
      expect(:get => "/unloading_catches/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/unloading_catches/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(:get => "/unloading_catches/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(:post => "/unloading_catches").to route_to("unloading_catches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/unloading_catches/1").to route_to("unloading_catches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/unloading_catches/1").to route_to("unloading_catches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/unloading_catches/1").to route_to("unloading_catches#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(unloading_catches_path).to eq("/unloading_catches") }
    
    I18n.available_locales.each do |locale|
      it { expect(unloading_catch_path(1, locale: locale)).to eq("/#{locale}/unloading_catches/1") }
    end
  end
end
