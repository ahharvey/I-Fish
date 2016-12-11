# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string
#  shark_policy    :boolean
#  iuu_list        :boolean
#  code_of_conduct :boolean
#  member          :boolean
#  avatar          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  code            :string
#  draft_id        :integer
#  published_at    :datetime
#  trashed_at      :datetime
#

require 'rails_helper'

RSpec.describe Company do

  let(:company1) { create :company, name: 'BBB', processing: true }
  let(:company2) { create :company, name: 'AAA', harvest: true }
  let(:company3) { create :company, name: 'AAA' }

  describe 'associations' do
    context 'belongs to' do
    end
    context 'has many' do
      it { is_expected.to have_many(:vessels) }
      it { is_expected.to have_many(:fisheries).through(:vessels) }
      it { is_expected.to have_many(:unloadings).through(:vessels) }
      it { is_expected.to have_many(:unloading_catches).through(:unloadings) }
      it { is_expected.to have_many(:bait_loadings).through(:vessels) }
      it { is_expected.to have_many(:documents) }
      it { is_expected.to have_many(:company_positions) }
      it { is_expected.to have_many(:users).through(:company_positions) }
    end
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:code).of_type(:string) }
    it { is_expected.to have_db_column(:avatar).of_type(:string) }
    it { is_expected.to have_db_column(:member).of_type(:boolean) }
    it { is_expected.to have_db_column(:shark_policy).of_type(:boolean) }
    it { is_expected.to have_db_column(:code_of_conduct).of_type(:boolean) }
    it { is_expected.to have_db_column(:iuu_list).of_type(:boolean) }
    it { is_expected.to have_db_column(:processing).of_type(:boolean) }
    it { is_expected.to have_db_column(:harvest).of_type(:boolean) }
  end

  describe ".default" do
    it "includes all records" do
      company1
      company2
      expect( Company.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Company.default).to eq([company2, company1])
    end
  end

  describe ".harvest" do
    it "includes all records" do
      company1
      company2
      company3
      expect( Company.harvest.count).to eq 1
      expect( Company.harvest).to eq([company2])
    end
  end

  describe ".processing" do
    it "includes all records" do
      company1
      company2
      company3
      expect( Company.processing.count).to eq 1
      expect( Company.processing).to eq([company1])
    end
  end

  describe ".unknown_type" do
    it "includes all records" do
      company1
      company2
      company3
      expect( Company.unknown_type.count).to eq 1
      expect( Company.unknown_type).to eq([company3])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

end
