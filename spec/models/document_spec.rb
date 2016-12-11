# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  file              :string
#  content_type      :string
#  file_size         :string
#  documentable_id   :integer
#  documentable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Document do



  let(:document1) { create :document, created_at: Time.now-1.hour }
  let(:document2) { create :document, created_at: Time.now }


  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:documentable) }
    end
  end

  describe ".default" do
    it "includes all records" do
      document1
      document2
      expect( Document.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Document.default).to eq([document2, document1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:file) }
    it { is_expected.to validate_presence_of(:documentable) }
  end


end
