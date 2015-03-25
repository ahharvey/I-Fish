class UnloadingCatch < ActiveRecord::Base
  belongs_to :fish
  belongs_to :unloading

  CUT_TYPES = ["wholeround", "dirtyloin", "cleanloin"]

end
