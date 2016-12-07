class UnloadingImporterJob < ApplicationJob
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

  def perform(importer_id )

    @importer         = Importer.find( importer_id )
    @owner            = @importer.imported_by
    @parent           = @importer.parent
    @label            = @importer.label


    @import_service = select_import_service_by(@label)

    @import_service.call

    if @import_service.imported

      rows = @import_service.imported_rows
      UserMailer.import_success( @owner.id, @owner.class.name, rows ).deliver_later

      @importer.approved!

      Rails.logger.info '------------IMPORT SAVED SUCCESSFULLY------------'

    else

      error_messages = @import_service.errors.messages[:base]
      UserMailer.import_failure( @owner.id, @owner.class.name, error_messages ).deliver_later

      @importer.rejected!

      Rails.logger.info '------------IMPORT FAILED------------'

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

  def select_import_service_by label
    case label
    when 'unloadings'
      Importers::CreateUnloadings.new(
        {
          file: @importer.file,
          imported_by: @importer.imported_by,
          parent: @importer.parent
        }
      )
    when 'bait_loadings'
      Importers::CreateBaitLoadings.new(
        {
          file: @importer.file,
          imported_by: @importer.imported_by,
          parent: @importer.parent
        }
      )
    when 'vessels'
      Importers::CreateVessels.new(
        {
          file: @importer.file,
          imported_by: @importer.imported_by,
          parent: @importer.parent
        }
      )
    else nil
    end
  end

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

  def import_vessels
    @vessel_import = VesselImporter.new( { file: @importer.file }  )

    if @vessel_import.save( @owner.id, @owner.class.name )

      rows = @vessel_import.imported_vessels
      UserMailer.import_success( @owner.id, @owner.class.name, rows ).deliver_later

      @importer.approved!

      Rails.logger.info '------------IMPORT SAVED SUCCESSFULLY------------'

    else

      error_messages = @vessel_import.errors.messages[:base]
      UserMailer.import_failure( @owner.id, @owner.class.name, error_messages ).deliver_later

      @importer.rejected!

      Rails.logger.info '------------IMPORT FAILED------------'

    end
  end
end
