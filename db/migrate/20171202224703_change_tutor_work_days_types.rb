class ChangeTutorWorkDaysTypes < ActiveRecord::Migration
  def change
    change_column :tutor_work_days, :start_time, :time
    change_column :tutor_work_days, :end_time, :time
    change_column :tutor_work_days, :num_students, :integer
  end
end
