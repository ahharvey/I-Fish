# == Schema Information
#
# Table name: audits
#
#  id             :integer          not null, primary key
#  admin_id       :integer
#  auditable_id   :integer
#  auditable_type :string
#  comment        :text
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Audit do



  let(:audit1) { create :audit, created_at: Time.now-1.minute }
  let(:audit2) { create :audit, created_at: Time.now }


  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:admin) }
      it { is_expected.to belong_to(:auditable) }
    end
  end

  describe ".default" do
    it "includes all records" do
      audit1
      audit2
      expect( Audit.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Audit.default).to eq([audit2, audit1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:admin) }
    it { is_expected.to validate_presence_of(:auditable) }
    it {
      is_expected.to validate_inclusion_of(:status).
        in_array( %w{ approved rejected reviewed } )
    }
  end


end
