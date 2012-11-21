class HomeController < ApplicationController
  def index
  end
  
  def upload_data
    @files = ExcelFile.all
  end
  
  def process_upload_data
    if ExcelFile.create(file: params[:file])
      flash[:success] = "Successfully upload data to database"
    else
      flash[:danger] = "Failed to upload data"
    end
    
    redirect_to root_url
  end
end
