require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin visits Importer Index" do

  describe "with signed in staff" do
    subject { page }

    let(:admin)     { create :admin  }
    let(:importer1) { create :importer, review_state: 'approved', label: 'vessels' }
    let(:importer2) { create :importer, label: 'bait_loadings' }


    before :each do
      importer1
      importer2
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit importers_path
    end

    it "displays the importers" do

      is_expected.to have_content 'Imported Data'

      expect( page.all('table#importers_table tbody tr').count ).to eq 2

      is_expected.to have_content 'Approved'
      is_expected.to have_content 'Pending'
      is_expected.to have_content 'test_sheet.xlsx', count: 2
      is_expected.to have_content 'Vessels'
      is_expected.to have_content 'Bait Loadings'


    end

  end

end
