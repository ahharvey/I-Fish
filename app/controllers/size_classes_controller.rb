class SizeClassesController < ApplicationController
  load_and_authorize_resource

  before_action :set_size_class, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json

  def index
    @size_classes = SizeClass.all
    respond_with(@size_classes)
  end

  def show
    respond_with(@size_class)
  end

  def new
    @size_class = SizeClass.new
    respond_with(@size_class)
  end

  def edit
  end

  def create
    @size_class = SizeClass.new(size_class_params)
    @size_class.save
    respond_with @size_class, location: -> { after_save_path_for(@size_class) }
  end

  def update
    @size_class.update(size_class_params)
    respond_with @size_class, location: -> { after_save_path_for(@size_class) }
  end

  def destroy
    @size_class.destroy
    respond_with(@size_class)
  end

  private
  
  def set_size_class
    @size_class = SizeClass.find(params[:id])
  end

  def size_class_params
    params.require(:size_class).permit(
      :upper,
      :lower,
      :median,
      :name
      )
  end

  def after_save_path_for(resource)
    size_class_path(resource)
  end
  
end




