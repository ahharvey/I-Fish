#class AdminsController < InheritedResources::Base
#  load_and_authorize_resource
#  actions :index, :show, :edit, :update
#  respond_to :html, :xml, :json#

#  def show
#    respond_to do |format|
#      @admin = Admin.find(params[:id])
#      @date_from = (DateTime.now - 1.years).strftime("%d/%m/%Y")
#      @date_to = DateTime.now.strftime("%d/%m/%Y")#

#      @chart = @admin.surveys.count(:group=>"date_trunc('month', date_published)", order: "date_trunc('month', date_published)")#

#      format.html { render }#

#      format.json do
#        col_headers = []
#        month_counts = []
#        from = DateTime.parse(params[:date_from])
#        to = DateTime.parse(params[:date_to])
#        (from.year..to.year).each do |y|
#          start_month = (from.year == y) ? from.month : 1
#          end_month = (to.year == y) ? to.month : 12#

#          (start_month..end_month).each do |m|
#            col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
#            month_counts.push surveys.select{ |s| s.date_published.year == y && s.date_published.month == m}.count
#          end
#        end
#        render json: {:col_headers => col_headers, :month_counts => month_counts }
#      end
#    end
#  end#

#  private
#  
#  def admin_params
#    params.require(:admin).permit( 
#)
#  end#
#

#end




class AdminsController < ApplicationController
  load_and_authorize_resource

  before_action :set_admin, only: [:show, :edit, :update, :destroy, :welcome]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  layout :select_layout

  def index
    @admins = Admin.all
    respond_with(@admins)
  end

  def show
    respond_with(@admin)
  end

  def new
    @admin = Admin.new
    respond_with(@admin)
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.save
    respond_with @admin, location: -> { after_save_path_for(@admin) }
  end

  def update
    @admin.update(admin_params)
    respond_with @admin, location: -> { after_save_path_for(@admin) }
  end

  def destroy
    @admin.destroy
    respond_with(@admin)
  end

  def welcome
    #respond_with(@admin)
  end

  def crop

  end

  private
  
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(
      :email, 
      :name, 
      :approved, 
      :office_id, 
      :avatar, 
      :crop_x, 
      :crop_y, 
      :crop_w, 
      :crop_h
      )
  end

  def after_save_path_for(resource)
    if params[:admin][:avatar].present?
      crop_admin_path(resource)
    else
      admin_path(resource)
    end
  end

  def select_layout
    if action_name == 'welcome'
      'signin'  
    else
      'application'
    end
  end

end

