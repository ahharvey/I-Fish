#module Api
#  module V1
#    class FishesController < ApplicationController
#      #respond_to [:json, :xml]
#      
#      def index
#        @fishes = Fish.all
#      end
#      
#      def show
#        @fish = Fish.find(params[:id])
#      end
#      
#      def create
#        respond_with Fish.create(fish_params)
#      end
#      
#      def update
#        respond_with Fish.update(params[:id], params[:fishes])
#      end
#      
#      def destroy
#        respond_with Fish.destroy(params[:id])
#      end#

#      private
#  
#      def fish_params
#        params.require(:fish).permit(  )
#      end
#    end
#  end
#end


module Api
  module V1
    class FishesController < Api::V1::BaseController

      private

        def fish_params
          params.require(:fish).permit(
            :code, 
            :english_name, 
            :family, 
            :fishbase_name, 
            :indonesia_name, 
            :order, 
            :scientific_name, 
            :a, 
            :b, 
            :max, 
            :mat, 
            :opt, 
            :threatened
            )
        end

        def query_params
          # this assumes that an album belongs to an artist and has an :artist_id
          # allowing us to filter by this
          params.permit(
            :code, 
            :english_name, 
            :fishbase_name, 
            :indonesia_name,  
            :scientific_name, 
            )
        end

    end
  end
end