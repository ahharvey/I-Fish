class Landing < ActiveRecord::Base
  attr_accessible :boat_size, :crew, :engine, :fuel, :gear_id, :grid_square, :quantity, :sail, :time_in, :time_out, :value, :vessel_name, :vessel_ref, :weight, :type,
    :power, :fishing_area, :survey_id
  
  belongs_to :gear
  belongs_to :survey

  has_many :catches, dependent: :destroy

  
  def self.import_from_email(params)
  	puts "begin import surveys from email:"
  	puts params
  	puts "-----------------------------------"
  end
end
