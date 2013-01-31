class EnginesController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]
end
