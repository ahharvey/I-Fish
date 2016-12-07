# == Schema Information
#
# Table name: matches
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  encountered_manta_id :integer
#  manta_id             :integer
#  reviewer_id          :integer
#  match_state          :string
#  review_state         :string
#  reviewed_at          :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
module Review
  class BaitLoadingsController < BaseController
    load_and_authorize_resource

    layout :select_layout


    def update
      @bait_loading = BaitLoading.find(params[:id])
      #@unloading.attributes = unloading_params
      msg = nil
      if bait_loading_params.has_key?(:review_state)
        case bait_loading_params[:review_state].to_s
        when 'approved'
          @bait_loading.build_approved(current_admin)
          msg = t('.approved')
        when 'rejected'
          @bait_loading.build_rejected(current_admin)
          msg = t('.rejected')
        when 'pending'
          @bait_loading.build_pending(current_admin)
          msg = t('.pending')
        else
          @bait_loading.update_attributes(bait_loading_params)
        end
      end
      respond_to do |format|
        if @bait_loading.save
          flash[:notice] = msg
          format.html { redirect_to @bait_loading, notice: msg }
          format.json { render 'bait_loadings/show', status: :created, location: @bait_loading }
          format.js   { render 'bait_loadings/show', locals: {:id => @bait_loading.id} }
        else
          flash[:error] = t('.error')
          format.html { render 'bait_loadings/show' }
          format.json { render json: @bait_loading.errors, status: :unprocessable_entity }
        end
      end
    end

  private


    def bait_loading_params
      params.require(:bait_loading).permit(
        :review_state
        )
    end

    def select_layout
      case action_name
      when 'index'
        'fullscreen'
      else
        'application'
      end
    end

  end
end
