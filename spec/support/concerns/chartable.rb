#require 'rails_helper'#

#shared_examples_for "chartable" do#
#

#  let(:model) 	    { described_class } # the class that includes the concern
#  let(:chartable)   { create model.to_s.underscore.to_sym } #an instance of the class that includes the concern#
#

#  before :each do
#	  commentable.comment_on_by user: commenter1, content: 'Comment 1'
#	  commentable.comment_on_by user: commenter2, content: 'Comment 2'
#	  commentable.comment_on_by user: commenter3, content: 'Comment 3'
#    commentable.reload
#	end#

#  describe '#to_monthly_production_chart' do
#    it { expect( model.to_monthly_production_chart ).to match_array [
#      {
#        name: "SCN"
#        data: {
#          "Jan"=>0,
#          "Feb"=>0,
#          "Mar"=>0,
#          "Apr"=>0,
#          "May"=>0,
#          "Jun"=>0,
#          "Jul"=>0,
#          "Aug"=>0,
#          "Sep"=>0,
#          "Oct"=>0,
#          "Nov"=>4,
#          "Dec"=>0
#          }
#        }
#      ] }
#  end#

#  describe '#to_monthly_cpue_chart' do
#    it { expect( model.to_monthly_production_chart ).to match_array [unloading1] }
#  end#

#  describe '#to_catch_composition_chart' do
#    it { expect( model.to_monthly_production_chart ).to match_array [unloading1] }
#  end#

#  describe '#to_monthly_fuel_utilization_chart' do
#    it { expect( model.to_monthly_production_chart ).to match_array [unloading1] }
#  end#
#

#  describe 'has obeccts' do
#    it 'has a commentable' do
#      expect( commentable.present? ).to be true
#    end
#    it 'has commenters' do
#      expect( commenter1.name ).to eq 'Commenter 1'
#      expect( commenter2.name ).to eq 'Commenter 2'
#      expect( commenter3.name ).to eq 'Commenter 3'
#      expect( commenter4.name ).to eq 'Commenter 4'
#    end
#  end#

#  it 'has comments' do
#    expect { commentable.comments_for }.to_not raise_error
#  end
#  it "has the correct number of comments" do
#    expect( commentable.comments_for.length ).to eq 3
#  end#

#  it 'has commenters' do
#    expect { commentable.commenters }.to_not raise_error
#  end
#  it "has the correct number of commenters" do
#    expect( commentable.commenters.length ).to eq 3
#  end#

#  it "fails validation with no commenter" do
#    invalid = commentable.comment_on_by content: 'Invalid comments'
#    #expect( invalid ).to be false
#    expect( invalid.errors.messages.size ).to eq(1)
#    expect( invalid.errors.messages[:user].join ).to eq "can't be blank"
#  end#

#  it "fails validation with no content" do
#    invalid = commentable.comment_on_by user: commenter1
#    #expect( invalid ).to be false
#    expect( invalid.errors.messages.size ).to eq(1)
#    expect( invalid.errors.messages[:content].join ).to eq "can't be blank"
#  end#

#  it "allows multiple comments per user" do
#    expect( commentable.find_comments_for.size).to eq 3
#    commentable.comment_on_by user: commenter1, content: 'Comment 4'
#    commentable.comment_on_by user: commenter1, content: 'Comment 5'
#    commentable.reload
#    expect( commentable.find_comments_for.size).to eq 5
#  end#

#  it "allows multiple comments by different users" do
#    expect(commentable.find_comments_for.size).to eq 3
#    commentable.comment_on_by user: commenter1, content: 'Comment 4'
#    commentable.comment_on_by user: commenter2, content: 'Comment 5'
#    commentable.reload
#    expect(commentable.find_comments_for.size).to eq 5
#  end#

#  it "should count valid comments as registered" do
#    commentable.comment_on_by user: commenter1, content: 'Comment 4'
#    expect( commentable.comment_registered?).to be true
#  end#

##  it "should not count the edit as being registered if active edits already exist" do
##    editable.edit_by user: editor1, name: 'Region 1'
##    editable.edit_by user: editor1, name: 'Region 1'
##    expect( editable.edit_registered? ).to be false
##  end#

#  it "returns true when commented_on_by commenter" do
#    expect( commentable.commented_on_by? commenter1 ).to be true
#  end#

#  it 'returns false when commented_on_by non-commenting user' do
#    expect( commentable.commented_on_by? commenter4 ).to eq false
#  end#

#  it 'gets the comments' do
#    expect( commentable.find_comments_for.pluck(:content) ).to match_array ['Comment 1', 'Comment 2', 'Comment 3']
#  end#
#

##  it 'approves the edit after 3 upvotes' do
##    expect( editable.get_approved_edits.length ).to eq 2
##    editable.edit_by user: editor1, name: 'Region 5'
##    editable.get_active_edit.vote_up editor2
##    editable.get_active_edit.vote_up editor3
##    editable.get_active_edit.vote_up editor4
##    expect( editable.get_approved_edits.length ).to eq 3 # we already set 2 in the before block
##  end#
###

##  it 'rejects the edit after 3 downvotes' do
##    expect( editable.get_approved_edits.length ).to eq 2
##    expect( editable.get_rejected_edits.length ).to eq 1
##    editable.edit_by user: editor1, name: 'Region 5'
##    editable.get_active_edit.vote_down editor2
##    editable.get_active_edit.vote_down editor3
##    editable.get_active_edit.vote_down editor4
##    expect( editable.get_approved_edits.length ).to eq 2
##    expect( editable.get_rejected_edits.length ).to eq 2
##  end#

#  it 'finds comments when conditions are provided' do
#    expect( commentable.find_comments_for( user_id: [commenter1.id, commenter3.id] ).length ).to eq 2
#    expect(
#      commentable.find_comments_for(
#        user_id: [commenter1.id, commenter3.id]
#        ).pluck(:content)
#      ).to match_array ['Comment 1', 'Comment 3']
#  end#

#  it 'counts the total number of comments' do
#    expect( commentable.count_total_comments ).to eq 3
#  end#

#end
