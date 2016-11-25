require "rails_helper"

RSpec.describe WppsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/wpps").to route_to("wpps#index")
    end

    it "routes to #new" do
      expect(:get => "/wpps/new").to route_to("wpps#new")
    end

    it "routes to #show" do
      expect(:get => "/wpps/1").to route_to("wpps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/wpps/1/edit").to route_to("wpps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/wpps").to route_to("wpps#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/wpps/1").to route_to("wpps#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/wpps/1").to route_to("wpps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/wpps/1").to route_to("wpps#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(wpps_path).to eq("/wpps") }
    it { expect(new_wpp_path).to eq("/wpps/new") }

    I18n.available_locales.each do |locale|
      it { expect(wpp_path(1, locale: locale)).to eq("/#{locale}/wpps/1") }
      it { expect(edit_wpp_path(1, locale: locale)).to eq("/#{locale}/wpps/1/edit") }
    end
  end
end
