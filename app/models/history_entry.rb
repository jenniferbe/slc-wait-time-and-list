class HistoryEntry < ActiveRecord::Base
  # enum appointment: [:drop_in, :scheduled, :weekly]
  belongs_to :student, foreign_key: "student_id"
  belongs_to :tutor, foreign_key: "tutor_sid"

  def self.get_histories_info(date)
    begin
      date = date.to_date.in_time_zone
    rescue
      header = "Please search for a date with the following format: MM-DD-YYYY"
      return [nil, nil, header]
    end
    histories = HistoryEntry.get_tables_for_date(date)
    if histories.nil?
      header = "No history entries were found for #{date.strftime('%A, %B %d, %Y')}"
    else
      found = true
    end
    [found, histories, header]
  end

  def self.get_tables_for_date(date)
    history = HistoryEntry.where({sign_in_time: date...(date + 1.days)})
    return nil if history.empty?
    drop_in_queue = history.where({meet_type: "drop-in"})
    weekly_queue = history.where({meet_type: "weekly"})
    scheduled_queue = history.where({meet_type: "scheduled"})
    [drop_in_queue, weekly_queue, scheduled_queue]
  end

end
