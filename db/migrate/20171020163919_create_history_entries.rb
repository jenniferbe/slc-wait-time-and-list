class CreateHistoryEntries < ActiveRecord::Migration
  def change
    create_table :history_entries do |t|

      t.integer :student_id #should be foreign key from 
      t.string :course
      t.integer :tutor_sid
      t.time :start_time #start_time => create time since students are added to the history after being seen.
      t.time :end_time
      t.string :tutor_notes
      t.time :wait_time

      #*** what will be the values of status? -- "finished", "cancelled", "didn't join queue" ---> just "no show"?
      t.string :status
      t.timestamps  #sort by create time.
    end
  end
end
