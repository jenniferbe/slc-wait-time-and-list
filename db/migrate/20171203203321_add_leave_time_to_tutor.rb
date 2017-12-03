class AddLeaveTimeToTutor < ActiveRecord::Migration
  def up
    add_column :tutors, :expected_leave_time, :datetime
  end
  def down
    remove_column :tutors, :expected_leave_time, :datetime
  end
end
