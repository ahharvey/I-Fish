class Memberships::FishesController < ApplicationController
  def create
    @fish = Fish.where(code: fish_params[:code]).first
    fetch_parent
    if @fish && @object
      name = @fish.code

      if @object.target_fishes.include?(@fish)
        flash[:notice]= I18n.t("fisheries.fishes.create.notice", fish: name, fishery: @object.name)
      else
       @object.target_fishes.push @fish
       flash[:success]= I18n.t("fisheries.fishes.create.success", fish: name, fishery: @object.name)
      end
    else
      @fish = nil
      flash[:error]= I18n.t("fisheries.fishes.create.error")
    end

    respond_to do |format|
      format.html { redirect_to @object }
      format.js { render :redisplay_fishes }
    end
  end


  def destroy
    @fish = Fish.find params[:id]
    fetch_parent
    @object.target_fishes.delete(@fish)
    respond_to do |format|
      format.html { redirect_to @object, notice: t('fisheries.fishes.destroy.notice', fish: @fish.code, fishery: @object.name ) }
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

  def fish_params
    params.require(:fish).permit(
      :code
      )
  end
end
