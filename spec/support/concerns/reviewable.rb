require 'rails_helper'

RSpec.shared_examples_for "reviewable" do

  let(:model) 	   { described_class } # the class that includes the concern
  let(:reviewable) { create model.to_s.underscore.to_sym } #an instance of the class that includes the concern
  let(:admin)         { create :admin }

  describe 'scopes' do
    it ".pending" do
      expect( model.pending.where_values_hash.with_indifferent_access ).to include( review_state: 'pending' )
    end
    it ".approved" do
      expect( model.approved.where_values_hash.with_indifferent_access ).to include( review_state: 'approved' )
    end
    it ".rejected" do
      expect( model.rejected.where_values_hash.with_indifferent_access ).to include( review_state: 'rejected' )
    end
  end

  describe "validations" do
    it {
      is_expected.to validate_inclusion_of(:review_state).
        in_array( %w{ approved rejected pending } )
    }

  end

  # pending
  #################
  describe '#pending!(admin)' do
    it 'updates the status' do
      expect(reviewable.review_state).to eq 'pending'
      reviewable.approved!(admin)
      expect(reviewable.review_state).to eq 'approved'
      reviewable.pending!(admin)
      expect(reviewable.review_state).to eq 'pending'
      expect(reviewable.reviewer_id).to eq nil
      expect(reviewable.reviewed_at).to eq nil
      expect(reviewable.changed?).to be false
    end
  end
  describe '#build_pending(admin)' do
    it 'builds the status' do
      expect(reviewable.review_state).to eq 'pending'
      reviewable.approved!(admin)
      expect(reviewable.review_state).to eq 'approved'
      expect(reviewable.reviewer_id).to eq admin.id
      reviewable.build_pending(admin)
      expect(reviewable.review_state).to eq 'pending'
      expect(reviewable.reviewer_id).to eq nil
      expect(reviewable.reviewed_at).to eq nil
      expect(reviewable.changed?).to be true
      expect(reviewable.changed).to include( 'review_state', 'reviewer_id', 'reviewed_at')
    end
  end
  describe '#pending?' do
    it 'queries the status' do
      expect(reviewable.pending?).to be true
      reviewable.approved!(admin)
      expect(reviewable.pending?).to be false
    end
  end

  # approved
  #################
  describe '#approved!(admin)' do
    it 'updates the status' do
      expect(reviewable.review_state).to eq 'pending'
      reviewable.approved!(admin)
      expect(reviewable.review_state).to eq 'approved'
      expect(reviewable.reviewer_id).to eq admin.id
      expect(reviewable.reviewed_at.change(:sec => 0) ).to eq Time.now.change(:sec => 0)
      expect(reviewable.changed?).to be false
    end
  end
  describe '#build_approved(admin)' do
    it 'updates the status' do
      expect(reviewable.review_state).to eq 'pending'
      reviewable.build_approved(admin)
      expect(reviewable.review_state).to eq 'approved'
      expect(reviewable.reviewer_id).to eq admin.id
      expect(reviewable.reviewed_at.change(:sec => 0) ).to eq Time.now.change(:sec => 0)
      expect(reviewable.changed?).to be true
      expect(reviewable.changed).to include( 'review_state', 'reviewer_id', 'reviewed_at')
    end
  end
  describe '#approved?' do
    it 'queries the status' do
      expect(reviewable.approved?).to be false
      reviewable.approved!(admin)
      expect(reviewable.approved?).to be true
    end
  end

  # rejected
  #################
  describe '#rejected!(admin)' do
    it 'updates the status' do
      expect(reviewable.review_state).to eq 'pending'
      reviewable.rejected!(admin)
      expect(reviewable.review_state).to eq 'rejected'
      expect(reviewable.reviewer_id).to eq admin.id
      expect(reviewable.reviewed_at.change(:sec => 0) ).to eq Time.now.change(:sec => 0)
      expect(reviewable.changed?).to be false
    end
  end
  describe '#build_rejected(admin)' do
    it 'updates the status' do
      expect(reviewable.review_state).to eq 'pending'
      reviewable.build_rejected(admin)
      expect(reviewable.review_state).to eq 'rejected'
      expect(reviewable.reviewer_id).to eq admin.id
      expect(reviewable.reviewed_at.change(:sec => 0) ).to eq Time.now.change(:sec => 0)
      expect(reviewable.changed?).to be true
      expect(reviewable.changed).to include( 'review_state', 'reviewer_id', 'reviewed_at')
    end
  end
  describe '#rejected?' do
    it 'queries the status' do
      expect(reviewable.rejected?).to be false
      reviewable.rejected!(admin)
      expect(reviewable.rejected?).to be true
    end
  end

end
