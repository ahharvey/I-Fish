require 'rails_helper'

#include Devise::TestHelpers
#include Warden::Test::Helpers

RSpec.describe "Staff Creates Unloading" do

  describe "with signed in staff" do
    let(:admin)     { create :admin, office: office }
    let(:office)    { create :office }
    let(:user)      { create :user }
    let(:vessel)    { create :vessel, company: company, fishery: fishery }
    let(:fishery)   { create :fishery }
    let(:company)   { create :company }
    let(:wpp)       { create :wpp }
    let(:port)      { create :port }
    let(:fish)      { create :fish }
    let(:unloading) { create :unloading, vessel: vessel }

    before :each do
      office.member_fisheries.push fishery
      vessel
      port
      wpp
      fish

      admin.roles.push Role.where(name: 'staff').first_or_create
      login_as( admin, scope: :admin )
      visit unloading_path(unloading)
    end

    it "approves the unloaidng" do

      expect(unloading.approved?).to be false

      expect(page).to have_link 'Approved'
      click_link("Approved")

      expect(page).to have_content 'Unloading approved!'
      unloading.reload
      expect(unloading.approved?).to be true
    end

    it "rejects the unloading" do

      expect(unloading.rejected?).to be false

      expect(page).to have_link 'Rejected'
      click_link("Rejected")

      expect(page).to have_content 'Unloading rejected!'
      unloading.reload
      expect(unloading.rejected?).to be true
    end

    it "marks the unloaidng as pending" do

      expect(unloading.pending?).to be true

      expect(page).to have_link 'Pending'
      click_link("Pending")

      expect(page).to have_content 'Unloading marked as pending!'
      unloading.reload
      expect(unloading.pending?).to be true
    end


  end


end
