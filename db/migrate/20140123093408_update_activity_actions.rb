class UpdateActivityActions < ActiveRecord::Migration
  def up
    Activity.where( action: "set_approved").each do |a|
      a.action = "approve"
      a.save
    end
  end

  def down
    Activity.where( action: "approve").each do |a|
      a.action = "set_approved"
      a.save
    end
  end
end
