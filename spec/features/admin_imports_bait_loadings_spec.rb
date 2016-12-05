require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin imports Bait Loadings" do

  describe "with signed in staff and managed company" do
    subject { page }

    let(:admin)     { create :admin, office: office  }
    let(:company)   { create :company }
    let(:vessel)    { create :vessel, company: company }
    let(:office)    { create :office }
    let(:fishery)   { create :fishery }

    before :each do
      vessel
      fishery.member_offices.push office
      fishery.member_companies.push company
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit root_path
    end

    it "creates with valid data" do

      is_expected.to have_link 'Import Data'
      click_link 'Import Data'

      is_expected.to have_link 'Import Bait Loadings'
      click_link 'Import Bait Loadings'

      is_expected.to have_content 'Select Vessel'
      is_expected.to have_content 'Which Vessel do you want to import Bait Loadings for?'

      is_expected.to have_content vessel.name
      is_expected.to have_content vessel.ap2hi_ref
      is_expected.to have_link "Import to #{vessel.ap2hi_ref}", href: new_vessel_importer_path(vessel, label: 'bait_loadings')
      click_link "Import to #{vessel.ap2hi_ref}"


      expect(current_path).to eq new_vessel_importer_path(vessel)
      is_expected.to have_content 'Import Bait Loadings'
      is_expected.to have_content "Bait Loadings will be added to #{vessel.name} (#{vessel.ap2hi_ref})"
      is_expected.to have_content 'You can import records contained in a CSV or Excel file. The first row must contain the column name. Only the following columns will be imported:'
      is_expected.to have_field 'File'
      is_expected.to have_button 'Import File'
      attach_file('File', File.absolute_path('./spec/support/files/test_sheet.xlsx'))
      click_button 'Import File'

      is_expected.to have_content 'Records were succesfully imported and are being processed'
      expect(current_path).to eq vessel_path(vessel)

    end

  end

end
