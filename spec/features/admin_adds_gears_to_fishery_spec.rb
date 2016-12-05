require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin adds new Gear to Fishery" do

  let(:admin)     { create :admin }
  let(:user)      { create :user }
  let(:fishery)   { create :fishery }
  let(:gear)      { create :gear }


  describe "with signed in staff and owned office" do

    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end

    it "adds unrecognized gear to the fishery" do
      expect(page).to have_field 'Add a gear'
      fill_in 'Add a gear', with: 'mail@example.com'
      click_button 'Add Gear'
      expect(page).to have_content "We were unable to add the gear to this fishery."
    end

    it "adds recognized admin to owned office" do
      expect(page).to have_field 'Add a gear'
      fill_in 'Add a gear', with: gear.alpha_code
      click_button 'Add Gear'
      expect(page).to have_content "#{gear.alpha_code} was successfully added to #{fishery.name}"
    end

    it "does not add member gear if already exists" do
      fishery.used_gears.push gear
      expect(page).to have_field 'Add a gear'
      fill_in 'Add a gear', with: gear.alpha_code
      click_button 'Add Gear'
      expect(page).to have_content "#{gear.alpha_code} is already assigned to #{fishery.name}"
    end

    it "does not add invalid gears to fishery" do
      expect(page).to have_field 'Add a gear'
      fill_in 'Add a gear', with: ""
      click_button 'Add Gear'
      expect(page).to have_content "We were unable to add the gear to this fishery"
    end

  end
  describe "with signed in staff and unowned office" do

    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end

    it "is unable to add gears" do
      expect(page).to_not have_field 'Add a gear'
      expect(page).to_not have_button 'Add Gear'
    end

  end

  describe "with signed in enumerator" do
    before :each do
      admin.roles.push Role.where(name: 'enumerator').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end
    it "does not create gears for unowned fishery" do
      expect(page).to_not have_field 'Add a gear'
      expect(page).to_not have_button 'Add Gear'
    end
  end

  describe "with signed in user" do
    before :each do
      login_as( user, scope: :user )
      visit fishery_path(fishery)
    end
    it "does not create gears for unowned fishery" do
      expect(page).to_not have_field 'Add a gear'
      expect(page).to_not have_button 'Add Gear'
    end
  end
end
