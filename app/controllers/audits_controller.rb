class AuditsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_auditable, only: [:index, :new, :create]

  before_action :set_audit, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :pdf, :except => [ :edit, :new, :update, :create ]

  def index
    @audits = @auditable.audits.default.page(params[:page])
  end

  def show
  end

  def new
    @audit = @auditable.audits.new
  end

  def create
    status = 'approved' if params[:commit] == 'Approve'
    status = 'rejected' if params[:commit] == 'Reject'
    @admin = current_admin
    @audit = @auditable.audits.build(
      audit_params.merge( admin_id: @admin.id, status: status )
      )

    if @audit.rejected?
      next_page = edit_polymorphic_path(@audit.auditable)
    else
      next_page = @audit.auditable if @audit.approved?
    end

    Rails.logger.info @audit.to_yaml

    respond_to do |format|
      if @audit.save
        format.html { redirect_to next_page, notice: t('.notice') }
        format.json { render :show, status: :created, location: @audit }
      else
        format.html { render :new }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @audit.update(audit_params)
        format.html { redirect_to @audit.auditable, notice: t('.notice') }
        format.json { render :show, status: :created, location: @audit }
      else
        format.html { render :edit }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @audit.destroy
    respond_to do |format|
      format.html { redirect_to @audit.auditable, notice: t('.notice') }
      format.json { head :no_content }
    end
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
