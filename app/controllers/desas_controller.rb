class DesasController < InheritedResources::Base
  load_and_authorize_resource

  def index
  	@placemarks = Desa.all.to_gmaps4rails do |desa, marker|
  		marker.infowindow render_to_string(:partial => "/desas/popup", :locals => { :object => desa})
  		marker.title   desa.name
      	marker.json({ :id => desa.id })
  	end
  end
end
