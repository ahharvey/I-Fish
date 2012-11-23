class HomeController < ApplicationController
  require 'mail'

  skip_before_filter :authenticate_user!, :verify_authenticity_token, :only => [:import_mail]
    
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

  def import_mail
    params[:message] = Base64.encode64(params[:message]).encode('utf-8')
    message = Mail.new(params[:message])
    email = message.from.first

    text, status = if message.has_attachments?
      attached = message.attachments.first.content_disposition.split('.').last
      if attached.eql?('xls') or attached.eql?('xlsx')
        filename = begin message.attachments.first.original_filename
        rescue
          begin
            message.attachments.first.filename
          rescue
            "Database_#{Digest::SHA1.hexdigest("--#{Time.now.to_s}--")[0,6]}.#{attached}"
          end
        end
        File.open(Rails.root+"/tmp/"+filename, "w+") { |file| file.write(message.attachments.first.read) }
        file = Rails.root+"/tmp/"+filename
        excel_info = File.open(file)
        excel_file = ExcelFile.new(file: excel_info)
        
        if excel_file.save
          excel_info.close
          logger.info("import by email : Successfully upload data to database")
          ["success", 200]
        else
          excel_info.close
          logger.info("import by email : Failed to upload data")
          ["Failed import data by email", 200]
        end
      else
        logger.info("There is no excel file on the email")
        ["Failed, There is no excel file on the email", 200]
      end
    else
      logger.info("There is no attached file on the email")
      ["Failed, There is no attached file on the email", 200]
    end

    render :text => text, :status => status
  end
end
