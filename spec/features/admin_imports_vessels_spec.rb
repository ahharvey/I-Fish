require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin imports Vessels" do

  describe "with signed in staff and managed company" do
    subject { page }

    let(:admin)     { create :admin, office: office  }
    let(:company)   { create :company }
    let(:office)    { create :office }
    let(:fishery)   { create :fishery }

    before :each do
      fishery.member_offices.push office
      fishery.member_companies.push company
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit root_path
    end

    it "creates with valid data" do

      is_expected.to have_link 'Import Data'
      click_link 'Import Data'

      is_expected.to have_link 'Import Vessels'
      click_link 'Import Vessels'

      is_expected.to have_content 'Select Company'
      is_expected.to have_content 'Which Company do you want to import vessels for?'
      is_expected.to have_content company.name
      is_expected.to have_content company.code
      is_expected.to have_link "Import to #{company.code}", href: new_company_importer_path(company, label: 'vessels')
      click_link "Import to #{company.code}"


      expect(current_path).to eq new_company_importer_path(company)
      is_expected.to have_content 'Import Vessels'
      is_expected.to have_content "Vessels will be added to #{company.name}"
      is_expected.to have_content 'You can import records contained in a CSV or Excel file. The first row must contain the column name. Only the following columns will be imported:'
      is_expected.to have_field 'File'
      is_expected.to have_button 'Import File'
      attach_file('File', File.absolute_path('./spec/support/files/test_sheet.xlsx'))
      click_button 'Import File'

      is_expected.to have_content 'Records were succesfully imported and are being processed'
      expect(current_path).to eq company_path(company)

    end

  end

end
