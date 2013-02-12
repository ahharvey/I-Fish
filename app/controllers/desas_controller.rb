class DesasController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json

  def index
  	@desas = Desa.all 
    @placemarks = @desas.to_gmaps4rails do |desa, marker|
  		marker.infowindow render_to_string(:partial => "/desas/popup", :locals => { :object => desa})
  		marker.title   desa.name
      	marker.json({ :id => desa.id })
  	end

    respond_to do |format|
      format.html
      format.json { render :json=>@desas }
      format.xml { render :xml=>@desas }
    end
  end

  def edit
  	@placemarks = @desa.to_gmaps4rails do |desa, marker|
      
      marker.title   desa.name
      marker.json({ :id => desa.id })
    end
  end

  def new
  	@placemarks = @desa.to_gmaps4rails do |desa, marker|
      
      marker.title   desa.name
      marker.json({ :id => desa.id })
    end
  end

  def show
    @placemarks = @desa.to_gmaps4rails do |desa, marker|
      
      marker.title   desa.name
      marker.json({ :id => desa.id })
    end

    respond_to do |format|
      format.html
      format.json { render :json=>@desa }
      format.xml { render :xml=>@desa }
    end
  end

  
end
