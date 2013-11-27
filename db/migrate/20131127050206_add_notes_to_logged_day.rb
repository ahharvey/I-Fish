class AddNotesToLoggedDay < ActiveRecord::Migration
  def change
    add_column :logged_days, :notes, :text
  end
end
