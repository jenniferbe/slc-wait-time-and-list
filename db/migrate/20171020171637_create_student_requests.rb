class CreateStudentRequests < ActiveRecord::Migration
  def change
    create_table :student_requests do |t|
      
      #entered by student, visible on tutor form
      
      t.integer :student_id #should be foreign key.
      t.string :course
      t.string :meet_type
      # Status takes the values "waiting", "cancelled" "active", or "finished"
      t.string :status
      t.time :wait_time
      t.integer :tutor_id
      t.timestamps  #sort by create time.
      
    end
  end
end
