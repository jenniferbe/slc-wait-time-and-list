class ChangeDataTypeOfStartTimeEndTimeInHistories < ActiveRecord::Migration
  def change
    change_column :history_entries, :start_time, :datetime
    change_column :history_entries, :end_time, :datetime
  end
end
