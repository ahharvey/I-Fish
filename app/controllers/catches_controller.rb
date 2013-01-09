class CatchesController < InheritedResources::Base
  load_and_authorize_resource

  before_filter :load_fish, only: [:new, :edit]

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  
  def index
    @catches = Catch.includes(:fish).all
  end

  def load_fish
    @fish = Fish.all
  end
end
