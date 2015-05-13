class LogbooksController < ApplicationController
  load_and_authorize_resource

  skip_before_filter :authenticate!

  before_action :set_logbook, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @logbooks = Logbook.includes( user: [:desa], :admin, :fishery).all
    respond_with(@logbooks)
  end

  def show
    respond_with(@logbook)
  end

  def new
    @logbook = Logbook.new
    respond_with(@logbook)
  end

  def edit
  end

  def create
    @logbook = Logbook.new(logbook_params)
    @logbook.save
    respond_with @logbook, location: -> { after_save_path_for(@logbook) }
  end

  def update
    @logbook.update(logbook_params)
    # respond_with @logbook, location: -> { after_save_path_for(@logbook) }
    respond_to do |format|
      if @logbook.update_attributes(logbook_params)
        flash[:success] = "Logbook updated successfully!"
        format.html { redirect_to(@logbook, :notice => 'Logbook was successfully updated.') }
        format.json { respond_with_bip(@logbook) }
      else
        flash[:error] = @logbook.errors.full_messages.join(", ")
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@logbook) }
      end
    end
  end

  def destroy
    @logbook.destroy
    respond_with(@logbook)
  end

  def approve
    @logbook = Logbook.find params[:id]
    #@logbook.update_column :approved, params[:approved]
    @logbook.approved!
    if @logbook.approved?
      track_activity @logbook
      @logbook.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("approved")
    else
      flash[:error] = review_error_msg
    end
    #render nothing: true
    refresh_supervisor_controls( @logbook )
  end

  def reject
    @logbook = Logbook.find( params[:id] )
    @logbook.rejected!
    if @logbook.rejected?
      track_activity @logbook
      @logbook.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("rejected")
    else
      flash[:error] = review_error_msg
    end
    #render nothing: true
    refresh_supervisor_controls( @logbook )
  end

  def pend
    @logbook = Logbook.find( params[:id] )
    @logbook.pending!
    if @logbook.pending?
      track_activity @logbook
      @logbook.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("pending")
    else
      flash[:error] = review_error_msg
    end
    #render nothing: true
    refresh_supervisor_controls( @logbook )
  end

  def user_avatar
    render partial: 'logbooks/user_avatar'
  end

  private
  
  def set_logbook
    @logbook = Logbook.find(params[:id])
  end

  def logbook_params
    params.require(:vessel).permit(
      :date, 
      :user_id, 
      :admin_id, 
      :fishery_id, 
      :review_state, 
      :reviewed_at, 
      :reviewer_id
      )
  end

  def after_save_path_for(resource)
    logbook_path(resource)
  end

  def refresh_supervisor_controls( logbook )
    respond_to do |format|
      format.html { redirect_to logbook  }
      format.js {
        @logbook = logbook 
        render :refresh_supervisor_controls
      }
    end
  end

  def review_success_msg( state )
    "Logbook successfully reviewed: #{state.upcase}"
  end

  def review_error_msg
    "We encountered an error reviewing this logbook. Please try again."
  end

end


