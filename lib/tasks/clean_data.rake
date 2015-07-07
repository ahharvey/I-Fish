namespace :clean_data do
  desc "cleaning data..........."
  task :merge_duplicates => :environment do
    associations = [:has_one, :has_many].inject([]) do |names, assoc|
      names += User.reflect_on_all_associations(assoc).map(&:name)
      names
    end

    duplicate_names = User.count(group: :name).select { |k, v| v > 1 }.keys

    duplicate_names.each do |name|
      users = User.where(:name => name)
      user_to_persist = users.order('created_at ASC').first

      users.each do |user|
        associations.each do |association|
          next unless user.send(association)
          if association == :versions
            user.send(association).update_all :whodunnit => user_to_persist.id
          elsif association == :activities
            user.send(association).update_all :ownable_id => user_to_persist.id
          else
            user.send(association).update_all :user_id => user_to_persist.id
          end
        end
      end

      users.keep_if { |u| u.id != user_to_persist.id }
      users.map(&:destroy)
    end
  end

  task :clean_booleans => :environment do 
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

    Vessel.all.each do |v|
      
      vessel_booleans.each do |bool|
        if v.send(bool).nil?
          v.bool = false
        end
      end

      v.save
    
    end

  end
end