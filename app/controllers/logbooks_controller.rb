class LogbooksController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def set_approved
  	@logbook = Logbook.find params[:id]
  	@logbook.update_column :approved, params[:approved]
  	if @logbook.approved == true
	  	@logbook.update_column :approver_id, current_admin.id
	  else
	  	@logbook.update_column :approver_id, ""
	  end
	  render nothing: true
	end
end
