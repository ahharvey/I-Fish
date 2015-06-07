module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :set_resource, only: [:destroy, :show, :update]
      respond_to :json, :xml
      before_action :doorkeeper_authorize!

      def create
        set_resource(resource_class.new(resource_params))

        if get_resource.save
          render :show, status: :created
        else
          # my code to ensure responsive to both json and xml
          render request.format.to_sym => get_resource.errors, status: :unprocessable_entity

          # alternatve approach for ensuring json and xml response
          # respond_with get_resource.errors, status: :unprocessable_entity

          ## origional suggested code
          # render json: get_resource.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/{plural_resource_name}/1
      def destroy
        get_resource.destroy
        head :no_content
      end

      # GET /api/{plural_resource_name}
      def index
        search_params
        if resource_name == 'fish'
          plural_resource_name = '@fishes'
        else
          plural_resource_name = "@#{resource_name.pluralize}"
        end
        if params.has_key?('q')
          Rails.logger.info search_params
          resources = resource_class.where("scientific_name ILIKE ?", "%#{search_params['q']}%" )
                                    .page(page_params[:page])
                                    .per(page_params[:page_size])
                                    .limit(limit_params[:limit])
        else
          Rails.logger.info "HHHHHHHHHHHHHHHH"
          resources = resource_class.where(query_params)
                                    .page(page_params[:page])
                                    .per(page_params[:page_size])
                                    .limit(limit_params[:limit])
        end
        instance_variable_set(plural_resource_name, resources)
        respond_with instance_variable_get(plural_resource_name)
      end

      # GET /api/{plural_resource_name}/1
      def show
        respond_with get_resource
      end

      # PATCH/PUT /api/{plural_resource_name}/1
      def update
        if get_resource.update(resource_params)
          render :show
        else
          # my code to ensure responsive to both json and xml
          render request.format.to_sym => get_resource.errors, status: :unprocessable_entity

          # alternatve approach for ensuring json and xml response
          # respond_with get_resource.errors, status: :unprocessable_entity

          ## origional suggested code
          # render json: get_resource.errors, status: :unprocessable_entity
        end
      end

      private

        # Returns the resource from the created instance variable
        # @return [Object]
        def get_resource
          instance_variable_get("@#{resource_name}")
        end

        # Returns the allowed parameters for searching
        # Override this method in each API controller
        # to permit additional parameters to search on
        # @return [Hash]
        def query_params
          {}
        end

        # Returns the allowed parameters for pagination
        # @return [Hash]
        def page_params
          params.permit(:page, :page_size)
        end

        def limit_params
          params.permit(:limit)
        end

        def version_params
          params.permit(:v)
        end

        def search_params
          params.permit(:q, :v, :format)
        end

        def format_params
          params.permit(:format)
        end

        # The resource class based on the controller
        # @return [Class]
        def resource_class
          @resource_class ||= resource_name.classify.constantize
        end

        # The singular name for the resource class based on the controller
        # @return [String]
        def resource_name
          @resource_name ||= self.controller_name.singularize
        end

        # Only allow a trusted parameter "white list" through.
        # If a single resource is loaded for #create or #update,
        # then the controller for the resource must implement
        # the method "#{resource_name}_params" to limit permitted
        # parameters for the individual model.
        def resource_params
          @resource_params ||= self.send("#{resource_name}_params")
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_resource(resource = nil)
          resource ||= resource_class.find(params[:id])
          instance_variable_set("@#{resource_name}", resource)
        end
    end
  end
end