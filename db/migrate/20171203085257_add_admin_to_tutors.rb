class AddAdminToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :admin, :boolean
  end
end
