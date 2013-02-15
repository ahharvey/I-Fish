class UserMailer < ActionMailer::Base
  default from: "fishnet@imacsindonesia.com"

  def data_upload_success(user, excel_file)
    @user = user
    @excel_file = excel_file
    mail(:to => @user.email, :subject => "Excel Spreadsheet upload succesful")
  end

  def data_upload_failure(user, excel_file)
    @user = user
    @excel_file = excel_file
    mail(:to => @user.email, :subject => "Excel Spreadsheet upload failure")
  end

  def new_admin_waiting_for_approval(new_admin, supervisors)
    @admin = new_admin
    @supervisors = supervisors
    @url  = new_admin_session_url  
    mail(:to => @supervisors.all.map(&:email), :subject => "APPROVAL REQUEST :: New Team Member")
  end

  def new_data_waiting_for_approval(data)
    @data = data
    @uploader = data.admin
    @supervisors = data.admin.supervisors
    @url = supervisor_dashboard_index_url
    mail(:to => @supervisors.all.map(&:email), :subject => "APPROVAL REQUEST :: New Survey Data")
  end
end
