# == Schema Information
#
# Table name: offices
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :integer
#

require 'rails_helper'

RSpec.describe Office do



  let(:office1) { create :office, name: 'BB' }
  let(:office2) { create :office, name: 'AA' }


  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to have_many(:admins) }
      it { is_expected.to have_and_belong_to_many(:member_fisheries) }
    end
  end

  describe ".default" do
    it "includes all records" do
      office1
      office2
      expect( Office.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Office.default).to eq([office2, office1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end


end
