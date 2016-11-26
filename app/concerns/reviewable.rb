module Reviewable
  extend ActiveSupport::Concern


  STATES = %w{ pending rejected approved }

  included do
    scope :pending, 	-> { where( review_state: 'pending' ) }
    scope :approved, 	-> { where( review_state: 'approved' ) }
    scope :rejected, 	-> { where( review_state: 'rejected' ) }

    validates :review_state,
      inclusion: { in: STATES },
      allow_blank: true
  end

  STATES.each do |state|

    define_method("#{state}?") do
      self.review_state == state
    end

    define_method("#{state}!") do |reviewer|
      return false      unless reviewer.class.name == 'Admin'
      params = build_review_state_params(state,reviewer)
      self.update_attributes( params )
    end

    define_method("build_#{state}") do |reviewer|
      return false      unless reviewer.class.name == 'Admin'
      params = build_review_state_params(state,reviewer)
      self.attributes = params
    end

  end

private

  def build_review_state_params state, admin
    params = { review_state: state }
    case state
    when  "approved", "rejected"
      params.merge!(
        reviewer_id: admin.id,
        reviewed_at: DateTime.now
        )

    when "pending"
      params.merge!(
        reviewer_id: nil,
        reviewed_at: nil
        )
    end
  end

end
