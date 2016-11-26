require "rails_helper"

RSpec.describe Review::UnloadingsController, type: :routing do

  describe "routing" do
    # nested

    it "routes to namespaced #update" do
      expect(:put => "/review/unloadings/1").to route_to("review/unloadings#update", id: "1" )
    end
    it "routes to namespaced #update" do
      expect(:patch => "/review/unloadings/1").to route_to("review/unloadings#update", id: "1" )
    end
  end

  describe :helpers do

    I18n.available_locales.each do |locale|
      it { expect( review_unloading_path(1, locale: locale) ).to  eq("/#{locale}/review/unloadings/1") }
    end
  end
end
