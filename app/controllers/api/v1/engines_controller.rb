module Api
  module V1
    class EnginesController < ApplicationController
      respond_to :json
      
      def index
        @engines = Engine.all
      end
      
      def show
        @engine = Engine.find(params[:id])
      end
      
      def create
        respond_with Engine.create(engine_params)
      end
      
      def update
        respond_with Engine.update(params[:id], params[:engines])
      end
      
      def destroy
        respond_with Engine.destroy(params[:id])
      end

      private

      def engine_params
        params.require(:engine).permit( :name, :code )
      end
    end
  end
end