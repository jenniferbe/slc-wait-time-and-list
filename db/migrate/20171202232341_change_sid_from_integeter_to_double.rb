class ChangeSidFromIntegeterToDouble < ActiveRecord::Migration
  def change
    change_column :history_entries, :student_id, :integer, :limit => 8
    change_column :history_entries, :tutor_sid, :integer, :limit => 8
    change_column :student_requests, :student_id, :integer, :limit => 8
    change_column :student_requests, :tutor_id, :integer, :limit => 8
    change_column :students, :sid, :integer, :limit => 8
    change_column :tutor_work_days, :tutor_id, :integer, :limit => 8
    change_column :tutors, :sid, :integer, :limit => 8
  end
end
