# == Schema Information
#
# Table name: vessels
#
#  id                 :integer          not null, primary key
#  name               :string
#  vessel_type_id     :integer
#  gear_id            :integer
#  flag_state         :string
#  year_built         :string
#  length             :integer
#  tonnage            :integer
#  imo_number         :string
#  shark_policy       :boolean          default(FALSE)
#  iuu_list           :boolean          default(FALSE)
#  code_of_conduct    :boolean          default(FALSE)
#  company_id         :integer
#  ap2hi_ref          :string
#  issf_ref           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  crew               :integer
#  hooks              :integer
#  captain            :string
#  owner              :string
#  sipi_number        :string
#  sipi_expiry        :date
#  siup_number        :string
#  issf_ref_requested :boolean          default(FALSE)
#  material_type      :string
#  machine_type       :string
#  capacity           :integer
#  vms                :boolean          default(FALSE)
#  tracker            :boolean          default(FALSE)
#  port               :string
#  name_changed       :boolean          default(FALSE)
#  flag_state_changed :boolean          default(FALSE)
#  radio              :boolean          default(FALSE)
#  relationship_type  :string
#  fish_capacity      :integer
#  bait_capacity      :integer
#  location_built     :string
#  seafdec_ref        :string
#  mmaf_ref           :string
#  dkp_ref            :string
#  status             :string
#  operational_type   :string
#  draft_id           :integer
#  published_at       :datetime
#  trashed_at         :datetime
#

require 'rails_helper'

RSpec.describe Vessel do

  let(:vessel1) { create :vessel, ap2hi_ref: 'BBB', tonnage: 5,  cert_type: 'certified', sipi_expiry: Date.today.end_of_year, sipi_number: '1234' }
  let(:vessel2) { create :vessel, ap2hi_ref: 'AAA', tonnage: 25, cert_type: 'in_assessment', member: true }
  let(:vessel3) { create :vessel, ap2hi_ref: 'AAA', tonnage: 50, cert_type: 'none' }
  let(:audit)   { create :audit, auditable: vessel3 }
  let(:document){ create :document, documentable: vessel1 }

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:company) }
      it { is_expected.to belong_to(:fishery) }
      it { is_expected.to belong_to(:gear) }
      it { is_expected.to belong_to(:vessel_type) }
      it { is_expected.to belong_to(:gear) }
    end
    context 'has many' do
      it { is_expected.to have_many(:unloadings) }
      it { is_expected.to have_many(:bait_loadings) }
      it { is_expected.to have_many(:unloading_catches).through(:unloadings) }
      it { is_expected.to have_many(:audits) }
      it { is_expected.to have_many(:documents) }
    end
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:ap2hi_ref).of_type(:string) }

    it { is_expected.to have_db_column(:material_type).of_type(:string) }
    it { is_expected.to have_db_column(:machine_type).of_type(:string) }
    it { is_expected.to have_db_column(:capacity).of_type(:integer) }
    it { is_expected.to have_db_column(:length).of_type(:integer) }
    it { is_expected.to have_db_column(:tonnage).of_type(:integer) }
    it { is_expected.to have_db_column(:fish_capacity).of_type(:integer) }
    it { is_expected.to have_db_column(:bait_capacity).of_type(:integer) }

    it { is_expected.to have_db_column(:vms).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:tracker).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:radio).of_type(:boolean).with_options(default: false) }

    it { is_expected.to have_db_column(:crew).of_type(:integer) }
    it { is_expected.to have_db_column(:hooks).of_type(:integer) }
    it { is_expected.to have_db_column(:captain).of_type(:string) }
    it { is_expected.to have_db_column(:owner).of_type(:string) }

    it { is_expected.to have_db_column(:flag_state).of_type(:string) }
    it { is_expected.to have_db_column(:year_built).of_type(:string) }
    it { is_expected.to have_db_column(:location_built).of_type(:string) }
    it { is_expected.to have_db_column(:name_changed).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:flag_state_changed).of_type(:boolean).with_options(default: false) }

    it { is_expected.to have_db_column(:seafdec_ref).of_type(:string) }
    it { is_expected.to have_db_column(:mmaf_ref).of_type(:string) }
    it { is_expected.to have_db_column(:dkp_ref).of_type(:string) }
    it { is_expected.to have_db_column(:imo_number).of_type(:string) }
    it { is_expected.to have_db_column(:issf_ref).of_type(:string) }
    it { is_expected.to have_db_column(:issf_ref_requested).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:sipi_number).of_type(:string) }
    it { is_expected.to have_db_column(:sipi_expiry).of_type(:date) }
    it { is_expected.to have_db_column(:siup_number).of_type(:string) }

    it { is_expected.to have_db_column(:relationship_type).of_type(:string) }
    it { is_expected.to have_db_column(:status).of_type(:string) }
    it { is_expected.to have_db_column(:operational_type).of_type(:string) }
    it { is_expected.to have_db_column(:cert_type).of_type(:string).with_options(default: 'none') }

    it { is_expected.to have_db_column(:member).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:marked).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:shark_policy).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:code_of_conduct).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:iuu_list).of_type(:boolean).with_options(default: false) }
  end

  describe ".default" do
    it "includes all records" do
      vessel1
      vessel2
      expect( Vessel.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Vessel.default).to eq([vessel2, vessel1])
    end
  end

  describe ".certified" do
    it "includes all records" do
      vessel1
      vessel2
      vessel2
      expect( Vessel.certified.count).to eq 1
      expect( Vessel.certified).to eq([vessel1])
    end
  end

  describe ".in_assessment" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      expect( Vessel.in_assessment.count).to eq 1
      expect( Vessel.in_assessment).to eq([vessel2])
    end
  end

  describe ".other_elligibles" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      expect( Vessel.other_elligibles.count).to eq 1
      expect( Vessel.other_elligibles).to eq([vessel3])
    end
  end

  describe ".sm" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      expect( Vessel.sm.count).to eq 1
      expect( Vessel.sm).to eq([vessel1])
    end
  end

  describe ".md" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      expect( Vessel.md.count).to eq 1
      expect( Vessel.md).to eq([vessel2])
    end
  end

  describe ".lg" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      expect( Vessel.lg.count).to eq 1
      expect( Vessel.lg).to eq([vessel3])
    end
  end

  describe ".ap2hi" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      expect( Vessel.ap2hi.count).to eq 1
      expect( Vessel.ap2hi).to eq([vessel2])
    end
  end

  describe ".audited_this_year" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      audit
      expect( Vessel.audited_this_year.count).to eq 1
      expect( Vessel.audited_this_year).to eq([vessel3])
    end
  end

  describe ".with_valid_docs" do
    it "includes all records" do
      vessel1
      vessel2
      vessel3
      document
      expect( Vessel.with_valid_docs.count).to eq 1
      expect( Vessel.with_valid_docs).to eq([vessel1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:ap2hi_ref) }
    it { is_expected.to validate_inclusion_of(:material_type).in_array( %w{ wood fiber steel } ) }
    it { is_expected.to validate_inclusion_of(:machine_type).in_array( %w{ none outboard inboard } ) }
    it { is_expected.to validate_inclusion_of(:relationship_type).in_array( %w{ contracted independent } ) }
    it { is_expected.to validate_inclusion_of(:operational_type).in_array( %w{ active inactive decommissioned } ) }
    it { is_expected.to validate_inclusion_of(:cert_type).in_array( %w{ none fip in_assessment certified } ) }
  end



end
