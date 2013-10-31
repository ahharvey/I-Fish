class ChangeSurveyAbortedToString < ActiveRecord::Migration
  def up
    remove_column :landings, :aborted 
    add_column :landings, :aborted, :string
  end

  def down
    remove_column :landings, :aborted 
    add_column :landings, :aborted, :boolean
  end
end
