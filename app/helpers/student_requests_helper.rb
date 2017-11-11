module StudentRequestsHelper
  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    # seconds_diff -= minutes * 60
    #
    # seconds = seconds_diff
    #
    # "#{hours.to_s.rjust(2, '0')}h:#{minutes.to_s.rjust(2, '0')}m:#{seconds.to_s.rjust(2, '0')}s"
    "#{hours.to_s.rjust(2, '0')}h:#{minutes.to_s.rjust(2, '0')}m"
  end
end
