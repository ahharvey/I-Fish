class HomeController < ApplicationController
  def index
  end
  
  def upload_data
    @files = ExcelFile.all
  end
  
  def process_upload_data
    excel_file = ExcelFile.new(file: params[:file])
    if excel_file.save
      flash[:success] = "Successfully upload data to database"
    else
      flash[:danger] = "Failed to upload data"
    end
    
    redirect_to home_upload_data_url
  end
end
