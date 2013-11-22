require "griddler"

class EmailProcessor
  def self.process(email)
    #authorize! :multipart_import, :home

    Rails.logger.info email.body
    
    admin   =   Admin.where(:email => email.from).first rescue nil
    xlsx    =   "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    xls     =   "application/vnd.ms-excel"
    
    text, status = if admin
      if email.attachments.size > 0 && email.attachments.all? { |a| a.content_type == xlsx || a.content_type == xls }
        for attachment in email.attachments
          
          parameters = {file: attachment, admin_id: id}
          excel_file = ExcelFile.new(parameters)
          
          ActiveRecord::Base.transaction do
            if excel_file.save

              UserMailer.data_upload_success(admin.id, excel_file.id)
              ["SUBMIT BY EMAIL SUCCESS.", 200]
              puts "SUBMIT BY EMAIL SUCCES."
              Rails.logger.info "SUBMIT BY EMAIL SUCCES."

            else
              
              UserMailer.data_upload_failure(admin.id, excel_file.errors.full_messages)
              ["SUBMIT BY EMAIL FAILED. Data errors were encountered.", 200]
              puts "SUBMIT BY EMAIL FAILED. Data errors were encountered."
              Rails.logger.info "SUBMIT BY EMAIL FAILED. Data errors were encountered."

            end
          end

        end
      else

        UserMailer.data_upload_failure_no_attachment(admin.id, attachments: email.attachments.map(&:original_filename) )
        ["SUBMIT BY EMAIL FAILED. No valid attachments.", 200]
        puts "SUBMIT BY EMAIL FAILED. No valid attachments."
        Rails.logger.info "SUBMIT BY EMAIL FAILED. No valid attachments."

      end
    else

      UserMailer.data_upload_failure_email_not_recognized(email.from)
      ["SUBMIT BY EMAIL FAILED. Unregistered email address.", 200]
      puts "SUBMIT BY EMAIL FAILED. Unregistered email address."
      Rails.logger.info "SUBMIT BY EMAIL FAILED. Unregistered email address."

    end

    Rails.logger.info(text)

    # render :text => text, :status => status
  end
end