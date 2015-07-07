class AuditsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_auditable

  before_action :set_audit, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :pdf, :except => [ :edit, :new, :update, :create ]

  def index
    @audits = @auditable.audits.default.page(params[:page])
    respond_with(@audits)
  end

  def show
    respond_with(@audit)
  end

  def new
    @audit = @auditable.audits.new
    respond_with(@audit)
  end

  def edit
  end

  def create
    Rails.logger.info "ZZZZZZZZZZ"
    @admin = current_admin.id
    Rails.logger.info "YYYYYYYYYYYY"
    @audit = @auditable.audits.create( audit_params.merge(:admin_id => @admin))
    Rails.logger.info "XXXXXXXXXXXXX"
    Rails.logger.info @audit.to_yaml
    respond_with @audit, location: -> { after_save_path_for(@audit) }
  end

  def update
    respond_with @audit, location: -> { after_save_path_for(@audit) }
  end

  def destroy
    respond_with(@audit)
  end

  private
  
  def set_audit
    @audit = Audit.find(params[:id])
  end

  def load_auditable
    Rails.logger.info "RRRRRRRRR"
    klass = [Vessel, Company].detect { |c| params["#{c.name.underscore}_id"]}
    Rails.logger.info "SSSSSSSSSSSS"
    Rails.logger.info klass
    @auditable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def audit_params
    params.require(:audit).permit(
      :comment, 
      :status
      )
  end



  def after_save_path_for(resource)
    Rails.logger.info "AAAAAAAAAAAAAAA"
    if params[:vessel_id].present?
      Rails.logger.info "BBBBBBBBBBBBBBBBB"
      @vessel = Vessel.find params[:vessel_id]
      if params[:audit][:status] == 'rejected'
        Rails.logger.info "CCCCCCCCCCCCCC"
        @pending_vessel = @vessel.pending_vessel
        if @pending_vessel.present?
          Rails.logger.info "DDDDDDDDDDDDDD"
          edit_pending_vessel_path(@pending_vessel.id)
        else
          Rails.logger.info "EEEEEEEEEEEEEE"
          new_audit_pending_vessel_path(resource)
        end
      else
        vessel_path(@vessel)
      end
    elsif params[:company_id].present?
      company_path(params[:company_id])
    end
  end

end