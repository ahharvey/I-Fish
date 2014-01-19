class LogbooksController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

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

  private

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
