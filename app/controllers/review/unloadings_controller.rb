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
  class UnloadingsController < BaseController
    load_and_authorize_resource

    layout :select_layout


    def update
      @unloading = Unloading.find(params[:id])
      #@unloading.attributes = unloading_params
      Rails.logger.info "HHHHHHHHHHHHHHHHHHHHHHHHHH"
      Rails.logger.info unloading_params
      Rails.logger.info unloading_params.has_key?(:review_state)
      Rails.logger.info unloading_params[:review_state]
      msg = nil
      if unloading_params.has_key?(:review_state)
        case unloading_params[:review_state].to_s
        when 'approved'
          @unloading.build_approved(current_admin)
          msg = t('.approved')
          Rails.logger.info "approved 2"
        when 'rejected'
          @unloading.build_rejected(current_admin)
          msg = t('.rejected')
          Rails.logger.info "rejected 2"
        when 'pending'
          @unloading.build_pending(current_admin)
          msg = t('.pending')
          Rails.logger.info "pending 2"
        end
      end
      respond_to do |format|
        Rails.logger.info @unloading.to_yaml
        Rails.logger.info @unloading.valid?
        Rails.logger.info @unloading.errors.messages
        if @unloading.save
          flash[:notice] = msg
          format.html { redirect_to @unloading, notice: msg }
          format.json { render 'unloadings/show', status: :created, location: @unloading }
          format.js   { render 'unloadings/show', locals: {:id => @unloading.id} }
        else
          flash[:error] = t('.error')
          format.html { render controller: :unloadings, action: :show }
          format.json { render json: @unloading.errors, status: :unprocessable_entity }
        end
      end
    end

  private


    def unloading_params
      params.require(:unloading).permit(
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
