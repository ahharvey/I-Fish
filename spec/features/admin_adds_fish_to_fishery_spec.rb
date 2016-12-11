require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Admin adds new Fish to Fishery" do

  let(:admin)     { create :admin, office: office }
  let(:user)      { create :user }
  let(:fishery)   { create :fishery }
  let(:fish)      { create :fish }
  let(:office)    { create :office }


  describe "with signed in staff and owned fishery" do

    before :each do
      office.member_fisheries.push fishery
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end

    it "adds unrecognized gear to the fishery" do
      expect(page).to have_field 'Add a fish'
      fill_in 'Add a fish', with: 'UnrecognizedFish'
      click_button 'Add Fish'
      expect(page).to have_content "We were unable to add the fish to this fishery."
    end

    it "adds recognized fish to the fishery" do
      expect(page).to have_field 'Add a fish'
      fill_in 'Add a fish', with: fish.code
      click_button 'Add Fish'
      expect(page).to have_content "#{fish.code} was successfully added to #{fishery.name}"
    end

    it "does not add member gear if already exists" do
      fishery.target_fishes.push fish
      expect(page).to have_field 'Add a fish'
      fill_in 'Add a fish', with: fish.code
      click_button 'Add Fish'
      expect(page).to have_content "#{fish.code} is already assigned to #{fishery.name}"
    end

    it "does not add invalid fish to fishery" do
      expect(page).to have_field 'Add a fish'
      fill_in 'Add a fish', with: ""
      click_button 'Add Fish'
      expect(page).to have_content "We were unable to add the fish to this fishery"
    end

  end
  describe "with signed in staff and unowned fishery" do

    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end

    it "is unable to add fish" do
      expect(page).to_not have_field 'Add a fish'
      expect(page).to_not have_button 'Add Fish'
    end

  end

  describe "with signed in enumerator" do
    before :each do
      admin.roles.push Role.where(name: 'enumerator').first_or_create
      login_as( admin, scope: :admin )
      visit fishery_path(fishery)
    end
    it "does not create fish for unowned fishery" do
      expect(page).to_not have_field 'Add a fish'
      expect(page).to_not have_button 'Add Fish'
    end
  end

  describe "with signed in user" do
    before :each do
      login_as( user, scope: :user )
      visit fishery_path(fishery)
    end
    it "does not create fish for unowned fishery" do
      expect(page).to_not have_field 'Add a fish'
      expect(page).to_not have_button 'Add Fish'
    end
  end
end
