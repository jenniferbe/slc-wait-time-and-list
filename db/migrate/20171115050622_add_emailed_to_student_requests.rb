class AddEmailedToStudentRequests < ActiveRecord::Migration
  def change
    add_column :student_requests, :emailed, :boolean
  end
end
