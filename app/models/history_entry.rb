class HistoryEntry < ActiveRecord::Base
  # enum appointment: [:drop_in, :scheduled, :weekly]
  belongs_to :student, foreign_key: "student_id"
  belongs_to :tutor, foreign_key: "tutor_sid"

  def self.get_tables_for_date(date)
    history = HistoryEntry.where({sign_in_time: date...(date + 1.days)})
    return nil if history.empty?
    drop_in_queue = history.where({meet_type: "drop-in"})
    weekly_queue = history.where({meet_type: "weekly"})
    scheduled_queue = history.where({meet_type: "scheduled"})
    [drop_in_queue, weekly_queue, scheduled_queue]
  end

end
