require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Staff adds Admin to Office" do

  describe "with signed in staff" do
    let(:admin)     { create :admin, office: office }
    let(:office)    { create :office }
    let(:office2)   { create :office }
    let(:fishery)   { create :fishery }

    before :each do
      fishery
      office2
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit root_path
    end

    it "creates admin for owned office" do

      expect(page).to have_link 'Offices'
      click_link 'Offices'

      expect(page).to have_content office.name
      expect(page).to have_link office.name
      click_link office.name

      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: 'mail@example.com'
      click_button 'add_admin'

      expect(page).to have_content "Team member was invited to #{office.name}"

    end

    it "does not create admins for unowned office" do

      expect(page).to have_link 'Offices'
      click_link 'Offices'

      expect(page).to have_content office2.name
      expect(page).to have_link office2.name
      click_link office2.name

      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'add_admin'

    end

  end
end
