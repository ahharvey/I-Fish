module Api
  module V1
    class UnloadingsController < ApplicationController
      respond_to :json

      #before_filter :restrict_access

      def index
        @unloadings = Unloading.last(5)
        render json: @unloadings
      end

      def page_params
        params.permit(:page, :page_size)
      end

      def limit_params
        params.permit(:limit)
      end

      def current_objects(params={})
        current_page = (params[:iDisplayStart].to_i/params[:iDisplayLength].to_i rescue 0)+1
        @current_objects = Unloading.page :page => current_page,
                                           :order => "#{datatable_columns(params[:iSortCol_0])} #{params[:sSortDir_0] || "DESC"}",
                                           :conditions => conditions,
                                           :per_page => params[:iDisplayLength]
      end

      def total_objects(params={})
        @total_objects = Unloading.count :include => [:user], :conditions => conditions
      end

      def conditions
        conditions = []
        conditions << "(unloadings.time_out ILIKE '%#{params[:sSearch]}%' OR objects.time_in ILIKE '%#{params[:sSearch]}%')" if(params[:sSearch])
        return conditions.join(" AND ")
      end

      def datatable_columns(column_id)
      case column_id.to_i
      when 1
        return "unloadings.time_out"
      when 2
        return "unloadings.time_in"
      else
        return "unloadings.id"
      end
    end


#      def show
#        respond_with Vessel.find(params[:id])
#      end
#
#      def create
#        respond_with User.create(user_params)
#      end
#
#      def update
#        respond_with User.update(params[:id], params[:users])
#      end
#
#      def destwhere(ap2hi_ref: params[:uvi])
#        respond_with User.destroy(params[:id])
#      end

#      private#

#      def user_params
#        params.require(:user).permit( :email, :password, :password_confirmation, :remember_me, :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :notes, :vessel_type_id, :length, :engine_id, :power, :desa_id, :confirmed_at)
#      end
    end
  end
end
