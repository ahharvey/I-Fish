class AddCapacityAndRegistrationFieldsToVessels < ActiveRecord::Migration
  def change
    add_column :vessels, :fish_capacity, :integer
    add_column :vessels, :bait_capacity, :integer
    add_column :vessels, :location_built, :string
    add_column :vessels, :seafdec_ref, :string
    add_column :vessels, :mmaf_ref, :string
    add_column :vessels, :dkp_ref, :string
  end
end
