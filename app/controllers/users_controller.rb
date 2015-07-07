
class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy, :welcome]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
    render layout: "signin"
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with @user, location: -> { after_save_path_for(@user) }
  end

  def update
    @user.update(user_params)
    respond_with @user, location: -> { after_save_path_for(@user) }
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  def welcome
    render layout: "signin"
  end

  def home
    redirect_to current_user
  end

  def crop

  end

  def report
    @date_from  = (DateTime.now - 1.years).strftime("%d/%m/%Y")
    @date_to    = DateTime.now.strftime("%d/%m/%Y")
    logbooks    = @user.logbooks.order("date")

    respond_with(@user) do |format|
      format.html { render }
      format.json do
        initialize_chart
        render json: { col_headers: col_headers, month_counts: month_counts }
      end
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email, 
      :password, 
      :password_confirmation, 
      :remember_me, 
      :name, 
      :avatar, 
      :crop_x, 
      :crop_y, 
      :crop_w, 
      :crop_h, 
      :notes, 
      :vessel_type_id, 
      :length, 
      :engine_id, 
      :power, 
      :desa_id, 
      :confirmed_at,
      :username, 
      :email, 
      :password, 
      :password_confirmation
      )
  end

  def after_save_path_for(resource)
    if params[:user][:avatar].present?
      crop_user_path(resource)
    else
      user_path(resource)
    end
  end

  def  initialize_chart
    col_headers = []
    month_counts = []
    from = DateTime.parse(params[:date_from])
    to = DateTime.parse(params[:date_to])
    (from.year..to.year).each do |y|
      start_month = (from.year == y) ? from.month : 1
      end_month = (to.year == y) ? to.month : 12

      (start_month..end_month).each do |m|
        col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
        month_counts.push logbooks.select{ |s| s.date.year == y && s.date.month == m}.count
      end
    end
  end

end

