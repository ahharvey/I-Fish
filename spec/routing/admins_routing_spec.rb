require "rails_helper"

RSpec.describe AdminsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admins").to route_to("admins#index")
    end

    it "routes to #new" do
      expect(:get => "/admins/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/admins/1").to route_to("admins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admins/1/edit").to route_to("admins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admins").to_not be_routable
    end

    it "routes to #update via PUT" do
      expect(:put => "/admins/1").to route_to("admins#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admins/1").to route_to("admins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admins/1").to_not be_routable
    end

  end
  describe :helpers do
    it { expect(admins_path).to eq("/admins") }

    I18n.available_locales.each do |locale|
      it { expect(admin_path(1, locale: locale)).to eq("/#{locale}/admins/1") }
      it { expect(edit_admin_path(1, locale: locale)).to eq("/#{locale}/admins/1/edit") }
    end
  end
end
