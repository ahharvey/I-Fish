require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin adds new Vessel to Fishery" do

  let(:admin)     { create :admin, office: office  }
  let(:user)      { create :user }
  let(:fishery)   { create :fishery }
  let(:vessel)    { create :vessel }
  let(:office)    { create :office }


  describe "with signed in staff and maanged fishery" do

    before :each do
      office.member_fisheries.push fishery
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end

    it "does not add unrecognized vessel" do
      expect(page).to have_field 'Add a vessel'
      expect(page).to have_button 'Add Vessel'
      fill_in 'Add a vessel', with: 'unrecognizedCode'
      click_button 'Add Vessel'
      expect(page).to have_content "We were unable to add the vessel to this fishery."
    end

    it "adds recognized vessel" do
      expect(page).to have_field 'Add a vessel'
      expect(page).to have_button 'Add Vessel'
      fill_in 'Add a gear', with: vessel.ap2hi_ref
      click_button 'Add Vessel'
      expect(page).to have_content "#{vessel.ap2hi_ref} was successfully added to #{fishery.name}"
    end

    it "does not add vessel if already added" do
      fishery.vessels.push vessel
      expect(page).to have_field 'Add a vessel'
      expect(page).to have_button 'Add Vessel'
      fill_in 'Add a gear', with: vessel.ap2hi_ref
      click_button 'Add Vessel'
      expect(page).to have_content "#{vessel.ap2hi_ref} is already assigned to #{fishery.name}"
    end

    it "does not add invalid vessel" do
      expect(page).to have_field 'Add a vessel'
      expect(page).to have_button 'Add Vessel'
      fill_in 'Add a vessel', with: ""
      click_button 'Add Vessel'
      expect(page).to have_content "We were unable to add the vessel to this fishery"
    end

  end
  describe "with signed in staff and unmanaged fishery" do

    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end

    it "is unable to add vessels" do
      expect(page).to_not have_field 'Add a vessel'
      expect(page).to_not have_button 'Add Vessel'
    end

  end

  describe "with signed in enumerator" do
    before :each do
      admin.roles.push Role.where(name: 'enumerator').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end
    it "is unable to add vessels" do
      expect(page).to_not have_field 'Add a vessel'
      expect(page).to_not have_button 'Add Vessel'
    end
  end

  describe "with signed in user" do
    before :each do
      login_as( user, scope: :user )
      visit fishery_path(fishery)
    end
    it "is unable to add vessels" do
      expect(page).to_not have_field 'Add a vessel'
      expect(page).to_not have_button 'Add Vessel'
    end
  end
end
