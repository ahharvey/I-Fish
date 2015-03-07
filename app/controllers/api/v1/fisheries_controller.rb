#module Api
#  module V1
#    class FisheriesController < ApplicationController
#      respond_to :json
#      
#      def index
#        @fisheries = Fishery.all
#      end
#      
#      def show
#        @fishery = Fishery.find(params[:id])
#      end
#      
#      def create
#        respond_with Fishery.create(fishery_params)
#      end
#      
#      def update
#        respond_with Fishery.update(params[:id], params[:fisheries])
#      end
#      
#      def destroy
#        respond_with Fishery.destroy(params[:id])
#      end#

#      private
#  
#      def fishery_params
#        params.require(:fishery).permit(  )
#      end
#    end
#  end
#end

module Api
  module V1
    class FisheriesController < Api::V1::BaseController

      private

        def fishery_params
          params.require(:fishery).permit(
            :code, 
            :name
            )
        end

        def query_params
          # this assumes that an album belongs to an artist and has an :artist_id
          # allowing us to filter by this
          params.permit(:code, :name)
        end

    end
  end
end