class Importer < ActiveRecord::Base
	mount_uploader :file, ExcelFileUploader

	before_create :set_status

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

  private

  def set_status
  	review_state = 'pending'
  end
end