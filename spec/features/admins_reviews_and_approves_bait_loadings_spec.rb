require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin reviews and approves Bait Loadings" do

  describe "with signed in staff" do

    subject { page }

    let(:admin)     { create :admin, office: office  }
    let(:office)    { create :office  }
    let(:vessel)    { create :vessel, company: company, fishery: fishery }
    let(:company )  { create :company }
    let(:fishery )  { create :fishery }
    let(:bait_loading)  { create :bait_loading, vessel: vessel }


    before :each do
      bait_loading
      10.times do |count|
         create(:bait_loading, vessel: vessel )
      end
      fishery.member_offices.push office
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

      within "table#bait_loadings.table" do
        is_expected.to have_selector 'tr.bait_loading', count: 10
        is_expected.to have_link 'Approved', count: 10
        is_expected.to have_link 'Rejected', count: 10
        is_expected.to have_link 'Pending', count: 10
      end

      expect(bait_loading.approved?).to be false
      save_and_open_page
      within "tr#bait_loading_#{bait_loading.id}" do
        click_link 'Approved'
      end

      expect(current_path).to eq bait_loading_path(bait_loading)

      is_expected.to have_content "Bait Loading approved!"
      bait_loading.reload
      expect(bait_loading.approved?).to be true

    end

    it "with JS is displays a modal form", :js do

      within "#nav_staff" do
        is_expected.to have_content '11'
        is_expected.to have_link 'Dashboard', href: staff_dashboard_index_path
        find('a[title="Dashboard"]').trigger('click')
      end


      is_expected.to have_content 'Dashboard', wait: 10
      expect(current_path).to eq staff_dashboard_index_path

      within "table#bait_loadings.table" do
        is_expected.to have_selector 'tr.bait_loading', count: 10
        is_expected.to have_link 'Approved', count: 10
        is_expected.to have_link 'Rejected', count: 10
        is_expected.to have_link 'Pending', count: 10
      end

      within 'div.modal-body', visible: false do
        is_expected.to_not have_link 'Approve'
        is_expected.to_not have_link 'Reject'
        is_expected.to_not have_link 'Pending'
      end

      expect(bait_loading.approved?).to be false

      within "tr#bait_loading_#{bait_loading.id}" do
        find('a[title="Approved"]').trigger 'click'
      end
      expect(current_path).to eq staff_dashboard_index_path

      is_expected.to have_content "Bait Loading approved!", wait: 10
      bait_loading.reload
      expect(bait_loading.approved?).to be true

    end

  end
end
