class CreateTutorWorkDays < ActiveRecord::Migration
  def change
    create_table :tutor_work_days do |t|
      t.integer :tutor_id
      t.time :start_time
      t.time :end_time
      t.integer :num_students

      t.timestamps null: false
    end
  end
end
