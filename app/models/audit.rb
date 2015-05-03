class Audit < ActiveRecord::Base
  belongs_to :user
  belongs_to :auditable, polymorphic: true

  STATES = %w{ approved rejected }

  STATES.each do |state|
    define_method("#{state}?") do
      self.status == state
    end

    define_method("#{state}!") do
      self.update_attributes(
        status: state
        )
    end
  end
end
