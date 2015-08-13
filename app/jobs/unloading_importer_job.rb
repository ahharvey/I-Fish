class UnloadingImporterJob < ActiveJob::Base
  queue_as :default
 
#  def perform(inviter_id, inviter_type, attributes = {})
#    Rails.logger.info attributes
#    @unloading_import = UnloadingImporter.new( attributes )
#    
#    if @unloading_import.save( inviter_id, inviter_type )
#      # redirect_to root_url, notice: "Imported unloadings successfully."
#      Rails.logger.info 'SUCCESS'
#    else
#      Rails.logger.info 'FAIL'
#      #render :new
#    end
#  end

  def perform(owner_id, owner_type, importer_id )

    @importer = Importer.find( importer_id )
    @user     = owner_type.constantize.find(owner_id)
    @unloading_import = UnloadingImporter.new( { file: @importer.file }  )

    if @unloading_import.save( owner_id, owner_type )
      # redirect_to root_url, notice: "Imported unloadings successfully."
      Rails.logger.info '------------IMPORT SAVED SUCCESSFULLY------------'
      rows = @unloading_import.imported_unloadings
      
      UserMailer.import_success( owner_id, owner_type, rows ).deliver_later
    else
      Rails.logger.info '------------IMPORT FAILED------------'
      error_messages = @unloading_import.errors.messages[:base]

      UserMailer.import_failure( owner_id, owner_type, error_messages ).deliver_later
      #render :new
    end

#    if imported_unloadings.map(&:valid?).all?
#      imported_unloadings.each do |unloading|
#        #UnloadingSaverJob.perform_later(unloading, owner_id, owner_type)
#        unloading.save!
#        Activity.create! action: 'create', trackable: unloading, ownable_id: owner_id, ownable_type: owner_type
#      end
#      true
#    else
#      imported_unloadings.each_with_index do |unloading, index|
#        unloading.errors.full_messages.each do |message|
#          errors.add :base, "Row #{index+2}: #{message}"
#        end
#      end
#      false
#    end
  end
end