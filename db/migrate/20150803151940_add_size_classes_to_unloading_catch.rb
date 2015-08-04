class AddSizeClassesToUnloadingCatch < ActiveRecord::Migration
  def change
    add_reference :unloading_catches, :size_class, index: true, foreign_key: true
  end
end
