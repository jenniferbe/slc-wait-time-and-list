class AddActiveToTutors < ActiveRecord::Migration
  def up
    add_column :tutors, :active, :boolean
  end
  def down
    remove_column :tutors, :active, :boolean
  end
end
