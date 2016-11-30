require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Staff adds Admin to Office" do

  let(:admin)     { create :admin, office: office }
  let(:user)      { create :user }
  let(:office)    { create :office }
  let(:office2)   { create :office }
  let(:fishery)   { create :fishery }

  describe "with signed in staff" do

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

  end

  describe "with signed in user" do


    before :each do
      fishery
      office2
      login_as( user, scope: :user )
      visit root_path
    end

    it "does not create admins for unowned office" do

      expect(page).to_not have_link 'Offices'

      visit office_path(office)
      
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'add_admin'

    end

  end
end
