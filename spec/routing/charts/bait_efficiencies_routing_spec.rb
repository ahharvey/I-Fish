require "rails_helper"

RSpec.describe Charts::BaitEfficienciesController, type: :routing do
  describe "routing" do
    # nested
    it "routes to nested company #index" do
      expect(:get => "/companies/1/charts/bait_efficiencies").to route_to("charts/bait_efficiencies#index", company_id: "1" )
    end
    it "routes to nested vessel #index" do
      expect(:get => "/vessels/1/charts/bait_efficiencies").to route_to("charts/bait_efficiencies#index", vessel_id: "1" )
    end
    it "routes to nested fishery #index" do
      expect(:get => "/fisheries/1/charts/bait_efficiencies").to route_to("charts/bait_efficiencies#index", fishery_id: "1" )
    end
    it "routes to nested port #index" do
      expect(:get => "/ports/1/charts/bait_efficiencies").to route_to("charts/bait_efficiencies#index", port_id: "1" )
    end
    it "routes to nested wpp #index" do
      expect(:get => "/wpps/1/charts/bait_efficiencies").to route_to("charts/bait_efficiencies#index", wpp_id: "1" )
    end
  end
  describe :helpers do
    I18n.available_locales.each do |locale|
      it { expect( company_charts_bait_efficiencies_path(1, locale: locale) ).to    eq("/#{locale}/companies/1/charts/bait_efficiencies") }
      it { expect( vessel_charts_bait_efficiencies_path(1, locale: locale) ).to     eq("/#{locale}/vessels/1/charts/bait_efficiencies") }
      it { expect( fishery_charts_bait_efficiencies_path(1, locale: locale) ).to    eq("/#{locale}/fisheries/1/charts/bait_efficiencies") }
      it { expect( port_charts_bait_efficiencies_path(1, locale: locale) ).to       eq("/#{locale}/ports/1/charts/bait_efficiencies") }
      it { expect( wpp_charts_bait_efficiencies_path(1, locale: locale) ).to        eq("/#{locale}/wpps/1/charts/bait_efficiencies") }
    end
  end
end
