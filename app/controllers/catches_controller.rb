class CatchesController < InheritedResources::Base
  before_filter :load_fish, only: [:new, :edit]
  
  def load_fish
    @fish = Fish.all
  end
end
