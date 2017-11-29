class ChangeStudentRequestsAndHistoryEntriesTime < ActiveRecord::Migration
  def change
    add_column :history_entries, :sign_in_time, :datetime
    remove_column :history_entries, :wait_time, :time
    remove_column :history_entries, :created_at, :string
    remove_column :history_entries, :updated_at, :string
    add_column :student_requests, :start_time, :datetime, :default => nil
  end
end
