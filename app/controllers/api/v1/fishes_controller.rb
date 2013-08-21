module Api
  module V1
    class FishesController < ApplicationController
      #respond_to [:json, :xml]
      
      def index
        @fishes = Fish.all
      end
      
      def show
        @fish = Fish.find(params[:id])
      end
      
      def create
        respond_with Fish.create(params[:fish])
      end
      
      def update
        respond_with Fish.update(params[:id], params[:fishes])
      end
      
      def destroy
        respond_with Fish.destroy(params[:id])
      end
    end
  end
end