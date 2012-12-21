class AddSurveyCountToAdmin < ActiveRecord::Migration
  
  def self.up
    add_column :admins, :surveys_count, :integer, :default => 0
    
    Admin.reset_column_information
  	Admin.all.each do |a|
  		Admin.reset_counters a.id, :surveys
  	end

    add_column :fisheries, :surveys_count, :integer, :default => 0
    
    Fishery.reset_column_information
  	Fishery.all.each do |f|
  		Fishery.reset_counters f.id, :surveys
  	end 	

    add_column :desas, :surveys_count, :integer, :default => 0
    
    Desa.reset_column_information
  	Desa.all.each do |d|
  		Desa.reset_counters d.id, :prereps
  	end
  end

  def self.down
    remove_column :admins, :surveys_count
    remove_column :fisheries, :surveys_count
    remove_column :desas, :surveys_count
  end

end
