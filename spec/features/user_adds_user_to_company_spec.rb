require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "User adds new User to Company" do

  let(:user1)     { create :user }
  let(:user2)     { create :user, name: 'User2' }
  let(:user3)     { create :user, name: 'User3' }
  let(:admin)     { create :admin }
  let(:company1)  { create :company }
  let(:company2)  { create :company }
  let(:fishery)   { create :fishery }
  let(:vessel)    { create :vessel, company: company1, fishery: fishery }


  describe "with signed in user and owned office" do

    before :each do
      company1.company_positions.create(user_id: user1.id, status: 'active')

      login_as( user1, scope: :user )
      visit company_path(company1)
    end

    it "adds unrecognized user to owned company" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: 'mail@example.com'
      click_button 'Add User'
      expect(page).to have_content "mail@example.com was successfully invited to #{company1.name}"
    end

    it "adds recognized user to owned company" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: user2.email
      click_button 'Add User'
      expect(page).to have_content "#{user2.name} was successfully added to #{company1.name}"
    end

    it "does not add member user to owned office" do
      company1.company_positions.create(user_id: user3.id, status: 'active')
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: user3.email
      click_button 'Add User'
      expect(page).to have_content "#{user3.name} is already a member of #{company1.name}"
    end

    it "does not add invalid admins to owned office" do
      expect(page).to have_field 'Add a team member'
      fill_in 'Add a team member', with: ""
      click_button 'Add User'
      expect(page).to have_content "We were unable to add the user to this company"
    end

  end
  describe "with signed in user and unowned company" do

    before :each do
      login_as( user1, scope: :user )
      visit company_path(company2)
    end

    it "is unable to add users" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add User'
    end

  end

  describe "with signed in enumerator and managed office" do
    before :each do
      admin.roles.push Role.where(name: 'enumerator').first_or_create
      fishery.member_companies.push company1
      fishery.member_offices.push admin.office
      login_as( admin, scope: :admin )
      visit company_path(company1)
    end
    it "does not create admins for unowned office" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add User'
    end
  end


  describe "with signed in enumerator and unmanaged office" do
    before :each do
      admin.roles.push Role.where(name: 'enumerator').first_or_create
      login_as( admin, scope: :admin )
      visit company_path(company1)
    end
    it "does not create admins for unowned office" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add User'
    end
  end

  describe "with signed in staff and managed company" do
    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      vessel
      fishery.member_offices.push admin.office
      login_as( admin, scope: :admin )
      visit company_path(company1)
    end
    it "adds users to managed company" do
      expect(page).to have_field 'Add a team member'
      expect(page).to have_button 'Add User'
    end
  end

  describe "with signed in staff and unmanaged company" do
    before :each do
      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit company_path(company1)
    end
    it "does not create admins for unmanaged office" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add User'
    end
  end

  describe "with signed in user" do
    before :each do
      login_as( user1, scope: :user )
      visit company_path(company1)
    end
    it "does not create admins for unowned office" do
      expect(page).to_not have_field 'Add a team member'
      expect(page).to_not have_button 'Add User'
    end
  end
end
