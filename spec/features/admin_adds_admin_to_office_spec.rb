require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin adds new Admin to Office" do

  let(:admin)     { create :admin, office: office }
  let(:admin2)    { create :admin, name: 'Admin2' }
  let(:admin3)    { create :admin, name: 'Admin3', office: office }
  let(:user)      { create :user }
  let(:office)    { create :office }
  let(:office2)   { create :office }
  let(:fishery)   { create :fishery }

  describe "with signed in staff and owned office" do

    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit office_path(office)
    end

    it "adds unrecognized admin to owned office" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: 'mail@example.com'
      click_button 'Add Admin'
      expect(page).to have_content "mail@example.com was successfully invited to #{office.name}"
    end

    it "adds recognized admin to owned office" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: admin2.email
      click_button 'Add Admin'
      expect(page).to have_content "#{admin2.name} was successfully added to #{office.name}"
    end

    it "does not adds member admin to owned office" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: admin3.email
      click_button 'Add Admin'
      expect(page).to have_content "#{admin3.name} is already a member of #{office.name}"
    end

    it "does not add invalid admins to owned office" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: ""
      click_button 'Add Admin'
      expect(page).to have_content "We were unable to add the admin to this office"
    end

  end
  describe "with signed in staff and unowned office" do

    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit office_path(office2)
    end

    it "is unable to add admins" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add Admin'
    end

  end

  describe "with signed in enumerator" do
    before :each do
      admin.roles.push Role.where(name: 'enumerator').first_or_create
      login_as( admin, scope: :admin )
      visit office_path(office)
    end
    it "does not create admins for unowned office" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add Admin'
    end
  end

  describe "with signed in user" do
    before :each do
      login_as( user, scope: :user )
      visit office_path(office)
    end
    it "does not create admins for unowned office" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add Admin'
    end
  end
end
