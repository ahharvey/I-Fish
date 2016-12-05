require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/home/index").to route_to("home#show", page: 'index')
    end

    it "routes to #upload_data" do
      expect(:get => "/home/import").to route_to("home#show", page: "import")
    end

    it "routes to #select_company" do
      expect(:get => "/home/select_company").to route_to("home#show", page: "select_company")
    end

    it "routes to #select_vessel" do
      expect(:get => "/home/select_vessel").to route_to("home#show", page: "select_vessel")
    end

  end
  describe :helpers do
    it { expect( page_path(page: 'index') ).to eq("/home/index") }
    it { expect( page_path(page: 'import') ).to eq("/home/import") }
    it { expect( page_path(page: 'select_company') ).to  eq("/home/select_company") }
    it { expect( page_path(page: 'select_vessel') ).to   eq("/home/select_vessel") }
  end
end
