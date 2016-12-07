require "rails_helper"

RSpec.describe Api::V1::UnloadingsController, type: :routing do
  describe "routing" do
    # nested
    it "routes to nested company #index" do
      expect(:get => "/api/unloadings").to route_to("api/v1/unloadings#index",format: 'json' )
    end
  end
  describe :helpers do
    #I18n.available_locales.each do |locale|
      it { expect( api_unloadings_path ).to    eq("/api/unloadings") }
    #end
  end
end
