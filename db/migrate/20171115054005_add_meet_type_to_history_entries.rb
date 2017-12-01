class AddMeetTypeToHistoryEntries < ActiveRecord::Migration
  def change
    add_column :history_entries, :meet_type, :string
  end
end
