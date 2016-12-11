# == Schema Information
#
# Table name: importers
#
#  id               :integer          not null, primary key
#  file             :text
#  label            :string
#  review_state     :string           default("pending")
#  reviewed_at      :datetime
#  parent_type      :string
#  parent_id        :integer
#  imported_by_type :string
#  imported_by_id   :integer
#



require 'rails_helper'

RSpec.describe Importer do



  let(:importer1) { create :importer, review_state: 'approved', reviewed_at: Time.now-3.hours }
  let(:importer2) { create :importer, review_state: 'rejected', reviewed_at: Time.now-5.hours }
  let(:importer3) { create :importer }

  describe 'associations' do
    context 'belong to' do
      it { is_expected.to belong_to(:imported_by) }
      it { is_expected.to belong_to(:parent) }
    end
  end

  describe ".scopes" do
    before :each do
      importer1
      importer2
      importer3
    end
    it "includes the correct records" do
      expect( Importer.default.count).to eq 3
      expect( Importer.default).to eq([importer3, importer1, importer2])

      expect( Importer.pending.count).to eq 1
      expect( Importer.pending).to eq([importer3])

      expect( Importer.rejected.count).to eq 1
      expect( Importer.rejected).to eq([importer2])

      expect( Importer.approved.count).to eq 1
      expect( Importer.approved).to eq([importer1])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:file) }
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:imported_by) }
    it { is_expected.to validate_presence_of(:parent) }
    it {
      is_expected.to validate_inclusion_of(:review_state).
        in_array( %w{ approved rejected pending } )
    }
    it {
      is_expected.to validate_inclusion_of(:label).
        in_array( %w{ vessels unloadings bait_loadings } )
    }
  end



end
