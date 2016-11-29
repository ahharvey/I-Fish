class UnloadingSaverJob < ApplicationJob
  queue_as :default

  def perform(unloading, owner_id, owner_type)
  	unloading.save!
    Activity.create! action: 'create', trackable: unloading, ownable_id: owner_id, ownable_type: owner_type
	end
end
