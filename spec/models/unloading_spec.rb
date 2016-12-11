# == Schema Information
#
# Table name: unloadings
#
#  id                :integer          not null, primary key
#  old_port          :string
#  time_out          :datetime
#  time_in           :datetime
#  etp               :boolean
#  location          :string
#  fuel              :integer
#  ice               :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  vessel_id         :integer
#  review_state      :string           default("pending")
#  byproduct         :integer
#  discard           :integer
#  yft               :integer
#  bet               :integer
#  skj               :integer
#  kaw               :integer
#  catch_certificate :string
#  budget            :integer
#  grid_id           :integer
#  port_id           :integer
#  wpp_id            :integer
#  reviewer_id       :integer
#  reviewed_at       :datetime
#  user_id           :integer
#  admin_id          :integer
#  cpue              :decimal(, )
#



require 'rails_helper'

RSpec.describe Unloading do



  let(:unloading1) { create :unloading, time_out: Time.now-2.hour, time_in: Time.now-1.hour, vms: true }
  let(:unloading2) { create :unloading, time_out: Time.now-1.hour, time_in: Time.now, port_sampling: true }
  let(:unloading3) { create :unloading, time_out: Time.now-1.hour, time_in: Time.now, observer: true }
  let(:wpp)        { create :wpp }
  let(:port)        { create :port }
  let(:fish1)        { create :fish, code: 'SKJ' }
  let(:fish2)        { create :fish, code: 'YFT' }
  let(:fish3)        { create :fish, code: 'BET' }
  let(:fish4)        { create :fish, code: 'KAW' }


  it_behaves_like "reviewable"

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:vessel) }
      it { is_expected.to belong_to(:wpp) }
      it { is_expected.to belong_to(:port) }
      it { is_expected.to belong_to(:user) }
      it {
        is_expected.to belong_to(:reviewer).
          class_name('Admin')
        }
    end

    context 'has many' do
      it { is_expected.to have_many(:unloading_catches) }
      it { is_expected.to have_many(:bait_loadings) }
      it { is_expected.to have_many(:fish).through(:unloading_catches) }
    end
    context 'nested attributes' do
      it {
        is_expected.to accept_nested_attributes_for(:unloading_catches).
          allow_destroy(true)
      }
      it {
        is_expected.to accept_nested_attributes_for(:bait_loadings).
          allow_destroy(true)
      }
    end
    context 'has one' do
      it { is_expected.to have_one(:company) }
    end
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:vessel_id).of_type(:integer) }
    it { is_expected.to have_db_column(:wpp_id).of_type(:integer) }
    it { is_expected.to have_db_column(:port_id).of_type(:integer) }
    it { is_expected.to have_db_column(:time_out).of_type(:datetime) }
    it { is_expected.to have_db_column(:time_in).of_type(:datetime) }
    it { is_expected.to have_db_column(:fuel).of_type(:integer) }
    it { is_expected.to have_db_column(:ice).of_type(:integer) }

    it { is_expected.to have_db_column(:observer).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:vms).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:port_sampling).of_type(:boolean).with_options(default: false) }

    it { is_expected.to have_db_column(:review_state).of_type(:string) }
    it { is_expected.to have_db_column(:reviewer_id).of_type(:integer) }
    it { is_expected.to have_db_column(:reviewed_at).of_type(:datetime) }
  end

  describe ".default" do
    it "includes all records" do
      unloading1
      unloading2
      expect( Unloading.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Unloading.default).to eq([unloading2, unloading1])
    end
  end

  describe ".with_port_sampling" do
    it "includes all records" do
      unloading1
      unloading2
      unloading3
      expect( Unloading.with_port_sampling.count).to eq 1
      expect( Unloading.with_port_sampling).to eq([unloading2])
    end
  end

  describe ".with_vms" do
    it "includes all records" do
      unloading1
      unloading2
      unloading3
      expect( Unloading.with_vms.count).to eq 1
      expect( Unloading.with_vms).to eq([unloading1])
    end
  end

  describe ".with_observers" do
    it "includes all records" do
      unloading1
      unloading2
      unloading3
      expect( Unloading.with_observers.count).to eq 1
      expect( Unloading.with_observers).to eq([unloading3])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:vessel) }
    it { is_expected.to validate_presence_of(:port) }
    it { is_expected.to validate_presence_of(:wpp) }
    it {
      is_expected.to validate_inclusion_of(:review_state).
        in_array( %w{ approved rejected pending } )
    }
  end

  describe "#wpp_code" do
    let(:unloading) { create :unloading, wpp_code: wpp.name }
    it "sets the wpp_id" do
      expect( Unloading.new(wpp_code: wpp.name).wpp_id ).to eq wpp.id
    end
    it "returns the wpp code" do
      expect(unloading.wpp_code).to eq wpp.name
    end
  end

  describe "#port_code" do
    let(:unloading) { create :unloading, port_code: port.name }
    it "sets the wpp_id" do
      expect(Unloading.new(port_code: port.name).port_id ).to eq port.id
    end
    it "returns the wpp code" do
      expect(unloading.port_code).to eq port.name
    end
  end

  describe "#skj_kg" do
    let(:unloading) { create :unloading, skj_kg: 50 }
    before :each do
      fish1
    end
    it "sets the skj_kg" do
      expect(unloading.unloading_catches.size).to eq 1
      expect(unloading.unloading_catches.first.fish_id).to eq fish1.id
      expect(unloading.unloading_catches.first.quantity).to eq 50
    end
    it "returns the skj_kg" do
      expect(unloading.skj_kg).to eq 50
    end
  end

  describe "#yft_kg" do
    let(:unloading) { create :unloading, yft_kg: 50 }
    before :each do
      fish2
    end
    it "sets the yft_kg" do
      expect(unloading.unloading_catches.size).to eq 1
      expect(unloading.unloading_catches.first.fish_id).to eq fish2.id
      expect(unloading.unloading_catches.first.quantity).to eq 50
    end
    it "returns the yft_kg" do
      expect(unloading.yft_kg).to eq 50
    end
  end

  describe "#bet_kg" do
    let(:unloading) { create :unloading, bet_kg: 50 }
    before :each do
      fish3
    end
    it "sets the bet_kg" do
      expect(unloading.unloading_catches.size).to eq 1
      expect(unloading.unloading_catches.first.fish_id).to eq fish3.id
      expect(unloading.unloading_catches.first.quantity).to eq 50
    end
    it "returns the bet_kg" do
      expect(unloading.bet_kg).to eq 50
    end
  end

  describe "#kaw_kg" do
    let(:unloading) { create :unloading, kaw_kg: 50 }
    before :each do
      fish4
    end
    it "sets the kaw_kg" do
      expect(unloading.unloading_catches.size).to eq 1
      expect(unloading.unloading_catches.first.fish_id).to eq fish4.id
      expect(unloading.unloading_catches.first.quantity).to eq 50
    end
    it "returns the kaw_kg" do
      expect(unloading.kaw_kg).to eq 50
    end
  end



end
