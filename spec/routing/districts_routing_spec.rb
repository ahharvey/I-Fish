require "rails_helper"

RSpec.describe DistrictsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/districts").to route_to("districts#index")
    end

    it "routes to #new" do
      expect(:get => "/districts/new").to route_to("districts#new")
    end

    it "routes to #show" do
      expect(:get => "/districts/1").to route_to("districts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/districts/1/edit").to route_to("districts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/districts").to route_to("districts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/districts/1").to route_to("districts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/districts/1").to route_to("districts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/districts/1").to route_to("districts#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(districts_path).to eq("/districts") }
    it { expect(new_district_path).to eq("/districts/new") }

    I18n.available_locales.each do |locale|
      it { expect(district_path(1, locale: locale)).to eq("/#{locale}/districts/1") }
      it { expect(edit_district_path(1, locale: locale)).to eq("/#{locale}/districts/1/edit") }
    end
  end
end
