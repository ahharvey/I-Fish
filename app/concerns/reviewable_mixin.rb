module ReviewableMixin

	STATES = %w{ pending rejected approved }

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
end


