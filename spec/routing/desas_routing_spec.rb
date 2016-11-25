require "rails_helper"

RSpec.describe DesasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/desas").to route_to("desas#index")
    end

    it "routes to #new" do
      expect(:get => "/desas/new").to route_to("desas#new")
    end

    it "routes to #show" do
      expect(:get => "/desas/1").to route_to("desas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/desas/1/edit").to route_to("desas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/desas").to route_to("desas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/desas/1").to route_to("desas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/desas/1").to route_to("desas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/desas/1").to route_to("desas#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(desas_path).to eq("/desas") }
    it { expect(new_desa_path).to eq("/desas/new") }

    I18n.available_locales.each do |locale|
      it { expect(desa_path(1, locale: locale)).to eq("/#{locale}/desas/1") }
      it { expect(edit_desa_path(1, locale: locale)).to eq("/#{locale}/desas/1/edit") }
    end
  end
end
