class HomeController < ApplicationController
  require 'mail'
  authorize_resource :class => false
  #skip_before_filter :authenticate!#, :verify_authenticity_token, :only => [:import_mail, :multipart_import]

  def index
    @surveys = Survey.includes(:admin, :desa, :fishery).page(params[:page]).per(15)
  end

  def reports
    authorize! :reports, :home
  end

 

  def multipart_import
    logger.info("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
    logger.info(params)
    logger.info(params[:attachments]["0"])
    logger.info(params[:envelope]["from"])
    logger.info("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
    admin = Admin.where(:email => params[:envelope]["from"]).first rescue nil
    id = admin.id rescue nil

    text, status = if admin
      if params[:attachments]["0"]
        parameters = {file: params[:attachments]["0"], admin_id: id}
        excel_file = ExcelFile.new(parameters)

        ActiveRecord::Base.transaction do
          if excel_file.save
            UserMailer.data_upload_success(admin, excel_file)
            ["Success to import data", 200]
          else
            logger.info("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
            logger.info(excel_file.errors.count)
            logger.info(excel_file.errors.full_messages)
            logger.info("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
            UserMailer.data_upload_failure(admin, excel_file)
            ["Failed, We have an error on the import data", 200]
          end
        end
      else
        ["Failed, there is no attached file", 200]
      end
    else
      ["Failed, unregistered email not allowed to import", 200]
    end

    logger.info(text)

    render :text => text, :status => status
  end

  def upload_data
    render_upload_data
  end

  def process_upload_data
    parameters = {file: params[:file], admin_id: @currently_signed_in.id}
    @model = ExcelFile.new(parameters)

    if @model.save
      flash[:success] = "Successfully upload data to database"
      redirect_to home_upload_data_url
    else
      flash[:danger] = "Failed to upload data"# + @model.errors.messages[:base].join(". ")
      render_upload_data
    end
  end

  def import_mail
    # message = Mail.new(params[:message])
    # user_id = User.where(:email => message.from.first).first.id rescue nil
    # logger.info(message.from.first)
    # logger.info("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
    # logger.info(user_id)
    # logger.info(User.where(:email => message.from.first))
    # logger.info(User.pluck(:email))
    # logger.info("-------------------------------")
    # text, status = if user_id
    #   logger.info("TEST EUY TEST TEST TEST")
    #   file = eval(message.attachments.first.read)
    #   Survey.import_from_email(@surveys, user_id)
    #   Landing.import_from_email(@fleets, user_id)
    #   Catch.import_from_email(@catches, user_id)
    #   logger.info("--------------------")

    #   ["success", 200]
    # else
    #   ["failed import data from email -- not registered user email", 200]
    # end

    # render :text => text, :status => status
  end

  #Landing

  def import_mail2
    message = Mail.new(params[:message])
    logger.info("===============================================================")
    logger.info(message.subject) #print the subject to the logs
    logger.info("body decode :" + message.body.decoded) #print the decoded body to the logs
    logger.info("inspect attachment pertama :"+message.attachments.first.inspect) #inspect the first attachment
    logger.info(message.from.first)
    logger.info(message.methods.sort)
    logger.info(message.attachments.first.attachment?)
    logger.info(message.attachments.first.has_attachments?)
    logger.info(message.attachments.first.decode_body)
    logger.info(message.attachments.first.read)
    logger.info("class name : #{message.attachments.first.read.class}")
    logger.info("===============================================================")
    email = User.where(:email => message.from.first)
    text, status = if !email.blank? and message.attachment?
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
        
        logger.info("testing... lihat aku woyyy "+message.attachments.first.content_transfer_encoding.to_s)
        attach_code = message.attachments.first.decoded
        File.open(Rails.root+"/tmp/"+filename, "w") { |file| file.write(attach_code) }
        file = Rails.root+"/tmp/"+filename
        excel_info = File.open(file)
        parameters = {file: excel_info, user_id: email.id}
        excel_file = ExcelFile.new(parameters)
        logger.info(excel_file)
        
        if excel_file.save
          excel_info.close
          logger.info("import by email : Successfully upload data to database")
          UserMailer.data_upload_success(@currently_signed_in, @model)
          ["success", 200]
        else
          excel_info.close
          logger.info(attach_code)
          logger.info(excel_file.errors)
          logger.info("import by email : Failed to upload data")
          UserMailer.data_upload_failure(@currently_signed_in, @model)
          ["Failed import data by email", 200]
        end
      else
        logger.info("There is no excel file on the email")
        ["Failed, There is no excel file on the email", 200]
      end
    elsif email.blank?
      logger.info("import by email : Failed to upload data")
      ["The email address not registered on our app.", 200]
    else
      logger.info("There is no attached file on the email")
      ["Failed, There is no attached file on the email", 200]
    end

    render :text => text, :status => status
  end

  def user_profile
  end

  def fishery_profile
  end

  private

  def render_upload_data
    @files = ExcelFile.all
    render :action => "upload_data"
  end
end
