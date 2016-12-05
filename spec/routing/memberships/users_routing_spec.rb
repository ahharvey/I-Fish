require "rails_helper"

RSpec.describe Memberships::UsersController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/companies/1/memberships/users").to_not be_routable
    end

    it "routes to #new" do
      expect(:get => "/companies/1/memberships/users/new").to_not be_routable
    end

    it "routes to #show" do
      expect(:get => "/companies/1/memberships/users/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(:get => "/companies/1/memberships/users/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(:post => "/companies/1/memberships/users").to route_to("memberships/users#create", company_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/companies/1/memberships/users/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/companies/1/memberships/users/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/companies/1/memberships/users/1").to route_to("memberships/users#destroy", id: "1", company_id: "1")
    end

  end
  describe :helpers do
    I18n.available_locales.each do |locale|
      it { expect(company_add_user_path(1, locale: locale)).to eq("/#{locale}/companies/1/memberships/users") }
      it { expect(company_remove_user_path(1, 1, locale: locale)).to eq("/#{locale}/companies/1/memberships/users/1") }
    end
  end
end
