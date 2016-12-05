require "rails_helper"

RSpec.describe Memberships::AdminsController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/offices/1/memberships/admins").to_not be_routable
    end

    it "routes to #new" do
      expect(:get => "/offices/1/memberships/admins/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/offices/1/memberships/admins/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(:get => "/offices/1/memberships/admins/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(:post => "/offices/1/memberships/admins").to route_to("memberships/admins#create", office_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/offices/1/memberships/admins/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/offices/1/memberships/admins/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/offices/1/memberships/admins/1").to route_to("memberships/admins#destroy", id: "1", office_id: "1")
    end

  end
  describe :helpers do
    I18n.available_locales.each do |locale|
      it { expect(office_add_admin_path(1, locale: locale)).to eq("/#{locale}/offices/1/memberships/admins") }
      it { expect(office_remove_admin_path(1, 1, locale: locale)).to eq("/#{locale}/offices/1/memberships/admins/1") }
    end
  end
end
