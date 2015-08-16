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

    @importer         = Importer.find( importer_id )
    @owner            = owner_type.constantize.find(owner_id)
    
    

    if @importer.label == 'unloadings'
      import_unloadings
    elsif @importer.label == 'bait_loadings'
      import_bait_loadings
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

  private

  def import_unloadings
    @unloading_import = UnloadingImporter.new( { file: @importer.file }  )

    if @unloading_import.save( @owner.id, @owner.class.name )     
      
      rows = @unloading_import.imported_unloadings
      UserMailer.import_success( @owner.id, @owner.class.name, rows ).deliver_later
      
      @importer.approved!

      Rails.logger.info '------------IMPORT SAVED SUCCESSFULLY------------'

    else
      
      error_messages = @unloading_import.errors.messages[:base]
      UserMailer.import_failure( @owner.id, @owner.class.name, error_messages ).deliver_later

      @importer.rejected!
      
      Rails.logger.info '------------IMPORT FAILED------------'

    end
  end

  def import_bait_loadings
    @bait_loading_import = BaitLoadingImporter.new( { file: @importer.file }  )

    if @bait_loading_import.save( @owner.id, @owner.class.name )     
      
      rows = @bait_loading_import.imported_bait_loadings
      UserMailer.import_success( @owner.id, @owner.class.name, rows ).deliver_later
      
      @importer.approved!

      Rails.logger.info '------------IMPORT SAVED SUCCESSFULLY------------'
      
    else
      
      error_messages = @bait_loading_import.errors.messages[:base]
      UserMailer.import_failure( @owner.id, @owner.class.name, error_messages ).deliver_later

      @importer.rejected!
      
      Rails.logger.info '------------IMPORT FAILED------------'

    end
  end
end