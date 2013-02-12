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

  def new_admin_waiting_for_approval(admin)
    @admin = admin
    @url  = new_admin_session_url
    mail(:to => admin.email, :subject => "APPROVAL REQUEST :: New Team Member")
  end
end
