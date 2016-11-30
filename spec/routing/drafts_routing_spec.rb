require "rails_helper"

RSpec.describe DraftsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/drafts").to_not be_routable # route_to("catches#index")
    end

    it "routes to #new" do
      expect(:get => "/drafts/new").to_not be_routable # route_to("catches#new")
    end

    it "routes to #show" do
      expect(:get => "/drafts/1").to_not be_routable # route_to("catches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/drafts/1/edit").to_not be_routable # route_to("catches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/drafts").to_not be_routable # route_to("catches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/drafts/1").to route_to("drafts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/drafts/1").to route_to("drafts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/drafts/1").to route_to("drafts#destroy", :id => "1")
    end

  end
  describe :helpers do
    

    I18n.available_locales.each do |locale|
      it { expect(draft_path(1, locale: locale)).to eq("/#{locale}/drafts/1") }

    end
  end
end
