require "rails_helper"

RSpec.describe Review::BaitLoadingsController, type: :routing do

  describe "routing" do
    # nested

    it "routes to namespaced #update" do
      expect(:put => "/review/bait_loadings/1").to route_to("review/bait_loadings#update", id: "1" )
    end
    it "routes to namespaced #update" do
      expect(:patch => "/review/bait_loadings/1").to route_to("review/bait_loadings#update", id: "1" )
    end
  end

  describe :helpers do

    I18n.available_locales.each do |locale|
      it { expect( review_bait_loading_path(1, locale: locale) ).to  eq("/#{locale}/review/bait_loadings/1") }
    end
  end
end
