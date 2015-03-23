class BaitLoading < ActiveRecord::Base
  belongs_to :vessel, touch: true
  belongs_to :fish, touch: true
  belongs_to :unloading, touch: true
end
