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

class Importer < ApplicationRecord

	STATES = %w{ pending rejected approved }

	belongs_to :parent, 			polymorphic: true
	belongs_to :imported_by, 	polymorphic: true

	scope :default, 	-> { order('importers.reviewed_at DESC') }
	scope :pending, 	-> { where( review_state: 'pending' ) }
	scope :approved, 	-> { where( review_state: 'approved' ) }
	scope :rejected, 	-> { where( review_state: 'rejected' ) }

	validates :file,
		presence: true
	validates :imported_by,
		presence: true
	validates :parent,
		presence: true
	validates :label,
		presence: true,
		inclusion: { in: %w{ vessels unloadings bait_loadings } }
	validates :review_state,
		inclusion: { in: STATES },
		allow_blank: true

	before_create :set_status

	mount_uploader :file, ExcelFileUploader


  STATES.each do |state|
    define_method("#{state}?") do
      self.review_state == state
    end
    define_method("#{state}!") do
      self.update_attributes(
        review_state: state,
        reviewed_at: DateTime.now
        )
    end
  end

private

  def set_status
  	review_state = 'pending'
  end
end
