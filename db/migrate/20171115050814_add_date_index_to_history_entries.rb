class AddDateIndexToHistoryEntries < ActiveRecord::Migration
  def change
    add_index :history_entries, :created_at
  end
end
