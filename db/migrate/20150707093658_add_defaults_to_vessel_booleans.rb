class AddDefaultsToVesselBooleans < ActiveRecord::Migration
  def change
  	vessel_booleans = [
			'vms', 
			'tracker',
			'shark_policy', 
			'iuu_list', 
			'code_of_conduct', 
			'issf_ref_requested', 
			'name_changed', 
			'flag_state_changed', 
			'radio'
		]

		vessel_booleans.each do |bool|
			change_column :vessels, bool.to_sym, :boolean, default: false
		end

		pending_vessel_booleans = [
			'vms',
			'tracker',
			'name_changed',
			'flag_state_changed'
		]

		pending_vessel_booleans.each do |bool|
			change_column :vessels, bool.to_sym, :boolean, default: false
		end
  end
end


