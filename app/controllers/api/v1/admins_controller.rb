module Api
  module V1
    class AdminsController < ApplicationController
      respond_to :json
      
      def index
        respond_with Admin.all
      end
      
      def show
        respond_with Admin.find(params[:id])
      end
      
      def create
        respond_with Admin.create(params[:admin])
      end
      
      def update
        respond_with Admin.update(params[:id], params[:admins])
      end
      
      def destroy
        respond_with Admin.destroy(params[:id])
      end
    end
  end
end