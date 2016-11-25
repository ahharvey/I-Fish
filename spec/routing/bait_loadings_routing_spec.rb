require "rails_helper"

RSpec.describe BaitLoadingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bait_loadings").to route_to("bait_loadings#index")
    end

    it "routes to #new" do
      expect(:get => "/bait_loadings/new").to route_to("bait_loadings#new")
    end

    it "routes to #show" do
      expect(:get => "/bait_loadings/1").to route_to("bait_loadings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bait_loadings/1/edit").to route_to("bait_loadings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bait_loadings").to route_to("bait_loadings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bait_loadings/1").to route_to("bait_loadings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bait_loadings/1").to route_to("bait_loadings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bait_loadings/1").to route_to("bait_loadings#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(bait_loadings_path).to eq("/bait_loadings") }
    it { expect(new_bait_loading_path).to eq("/bait_loadings/new") }

    I18n.available_locales.each do |locale|
      it { expect(bait_loading_path(1, locale: locale)).to eq("/#{locale}/bait_loadings/1") }
      it { expect(edit_bait_loading_path(1, locale: locale)).to eq("/#{locale}/bait_loadings/1/edit") }
    end
  end
end
