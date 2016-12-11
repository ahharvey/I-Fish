class Memberships::VesselsController < ApplicationController
  # authorize_resource :class => false
  def create
    @vessel = Vessel.where(ap2hi_ref: vessel_params[:ap2hi_ref]).first
    fetch_parent
    if @vessel && @object
      name = @vessel.ap2hi_ref

      if @object.vessels.include?(@vessel)
        flash[:notice]= I18n.t("fisheries.vessels.create.notice", vessel: name, fishery: @object.name)
      else
       @object.vessels.push @vessel
       flash[:success]= I18n.t("fisheries.vessels.create.success", vessel: name, fishery: @object.name)
      end
    else
      @vessel = nil
      flash[:error]= I18n.t("fisheries.vessels.create.error")
    end

    respond_to do |format|
      format.html { redirect_to @object }
      format.js { render :redisplay_vessels }
    end
  end
  def destroy
    @vessel = Vessel.find params[:id]
    fetch_parent
    @object.vessels.delete(@vessel)
    respond_to do |format|
      format.html { redirect_to @object, notice: t('fisheries.vessels.destroy.notice', vessel: @vessel.ap2hi_ref, fishery: @object.name ) }
      format.js { render :redisplay_fishes }
    end
  end
private
  def fetch_parent
    if klass = [Fishery].detect { |k| params["#{k.name.underscore}_id"]}
      @object = klass.find( params["#{klass.name.underscore}_id"] )
    else
      @object = nil
    end
  end

  def vessel_params
    params.require(:vessel).permit(
      :ap2hi_ref
      )
  end
end
