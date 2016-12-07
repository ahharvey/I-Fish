require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin reviews and approves Unloadings" do

  describe "with signed in staff" do

    subject { page }

    let(:admin)     { create :admin, office: office  }
    let(:office)    { create :office  }
    let(:vessel)    { create :vessel, company: company }
    let(:company )  { create :company }
    let(:fishery )  { create :fishery }
    let(:unloading) { create :unloading, vessel: vessel }



    before :each do
      10.times do |count|
         create(:unloading, vessel: vessel )
      end
      unloading
      fishery.member_offices.push office
      fishery.member_companies.push company
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit root_path
    end
    it "shows 10 unloadings, and navigates to show on view" do

      within "#nav_staff" do
        is_expected.to have_content '11'
        is_expected.to have_link 'Dashboard', href: staff_dashboard_index_path
      end

      click_link 'Dashboard'
      expect(current_path).to eq staff_dashboard_index_path

      within "table#unloadings.table" do
        is_expected.to have_selector 'tr.unloading', count: 10
        is_expected.to have_link 'View', count: 10
      end

      within "tr#unloading_#{unloading.id}" do
        click_link 'View'
      end

      expect(current_path).to eq unloading_path(unloading)
      expect(unloading.approved?).to be false
      is_expected.to have_link 'Approve'
      is_expected.to have_link 'Reject'
      is_expected.to have_link 'Pending'

      click_link 'Approve'

      is_expected.to have_content "Unloading approved!"
      unloading.reload
      expect(unloading.approved?).to be true

    end

    it "with JS is displays a modal form", :js do

      within "#nav_staff" do
        is_expected.to have_content '11'
        is_expected.to have_link 'Dashboard', href: staff_dashboard_index_path
        find('a[title="Dashboard"]').trigger('click')
      end


      is_expected.to have_content 'Dashboard', wait: 10
      expect(current_path).to eq staff_dashboard_index_path

      within "table#unloadings.table" do
        is_expected.to have_selector 'tr.unloading', count: 10
        is_expected.to have_link 'View', count: 10
      end

      within 'div.modal-body', visible: false do
        is_expected.to_not have_link 'Approve'
        is_expected.to_not have_link 'Reject'
        is_expected.to_not have_link 'Pending'
      end

      within "tr#unloading_#{unloading.id}" do
        find("a", text: 'View').trigger 'click'
      end
      expect(current_path).to eq staff_dashboard_index_path
      expect(unloading.approved?).to be false

      within 'div.modal' do
        is_expected.to have_link 'Approved'
        is_expected.to have_link 'Rejected'
        is_expected.to have_link 'Pending'
        find("a", text: 'Approved').trigger 'click'
      end

      is_expected.to have_content "Unloading approved!", wait: 30
      unloading.reload
      expect(unloading.approved?).to be true
    end

  end
end
