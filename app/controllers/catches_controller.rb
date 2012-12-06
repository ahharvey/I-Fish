class CatchesController < InheritedResources::Base
  load_and_authorize_resource

  before_filter :load_fish, only: [:new, :edit]

  def load_fish
    @fish = Fish.all
  end
end
