require "rails_helper"

RSpec.describe LogbooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/logbooks").to route_to("logbooks#index")
    end

    it "routes to #new" do
      expect(:get => "/logbooks/new").to route_to("logbooks#new")
    end

    it "routes to #show" do
      expect(:get => "/logbooks/1").to route_to("logbooks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/logbooks/1/edit").to route_to("logbooks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/logbooks").to route_to("logbooks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/logbooks/1").to route_to("logbooks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/logbooks/1").to route_to("logbooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/logbooks/1").to route_to("logbooks#destroy", :id => "1")
    end

  end
  describe :helpers do
    it { expect(logbooks_path).to eq("/logbooks") }
    it { expect(new_logbook_path).to eq("/logbooks/new") }

    I18n.available_locales.each do |locale|
      it { expect(logbook_path(1, locale: locale)).to eq("/#{locale}/logbooks/1") }
      it { expect(edit_logbook_path(1, locale: locale)).to eq("/#{locale}/logbooks/1/edit") }
    end
  end
end
