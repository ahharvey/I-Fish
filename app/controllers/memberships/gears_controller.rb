class Memberships::GearsController < ApplicationController
  def create
    @gear = Gear.where(alpha_code: gear_params[:get_gear]).first
    fetch_parent
    if @gear && @object
      name = @gear.alpha_code

      if @object.used_gears.include?(@gear)
        flash[:notice]= I18n.t("fisheries.gears.create.notice", gear: name, fishery: @object.name)
      else
       @object.used_gears.push @gear
       flash[:success]= I18n.t("fisheries.gears.create.success", gear: name, fishery: @object.name)
      end
    else
      @gear = nil
      flash[:error]= I18n.t("fisheries.gears.create.error")
    end

    respond_to do |format|
      format.html { redirect_to @object }
      format.js { render :redisplay_gears }
    end
  end


  def destroy
    @gear = Gear.find params[:id]
    fetch_parent
    @object.used_gears.delete(@gear)
    respond_to do |format|
      format.html { redirect_to @object, notice: t('fisheries.gears.destroy.notice', gear: @gear.alpha_code, fishery: @object.name ) }
      format.js { render :redisplay_gears }
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

  def gear_params
    params.require(:gear).permit(
      :get_gear
      )
  end
end
