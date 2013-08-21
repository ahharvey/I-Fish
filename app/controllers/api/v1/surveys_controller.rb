module Api
  module V1
    class SurveysController < ApplicationController
      respond_to :json
      
      def index
        @surveys = Survey.where(approved: true)
      end
      
      def show
        @survey = Survey.find(params[:id])
      end
      
      def create
        respond_with Survey.create(params[:survey])
      end
      
      def update
        respond_with Survey.update(params[:id], params[:surveys])
      end
      
      def destroy
        respond_with Survey.destroy(params[:id])
      end
    end
  end
end