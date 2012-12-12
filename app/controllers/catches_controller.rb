class CatchesController < InheritedResources::Base
  before_filter :load_fish, only: [:new, :edit]
  
  def index
    @catches = Catch.includes(:fish).all
  end

  def load_fish
    @fish = Fish.all
  end
end
