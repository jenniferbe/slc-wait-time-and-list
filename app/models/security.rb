class Security
  def self.app_firewall_password
    "slc123"
  end
  def self.tutor_firewall_password
    "tutor123"
  end

  def self.logged_in_app?
    #base case

  end
  def self.logged_in_tutor?
    if(session["tutorauth"] == true)
      return true
    end
    return false
  end
end