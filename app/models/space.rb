
class Space < ApplicationRecord
  MIN_LENGTH = 5
  MAX_LENGTH = 30

  validates :start_time, :end_time, length: {is: 5}

  belongs_to :patient
  belongs_to :doctor
  validate :actual_date, :actual_time, :time_inv, :division, :length_interval

  def actual_date
    errors.add(:base, 'incorrect date') if create_date < Time.now.to_date
  end


  def actual_time
    errors.add(:base, 'Invalid interval') if Time.parse(start_time) < Time.now && Time.parse(end_time) < Time.now
  end

  def time_inv
    errors.add(:base, 'REVERS NOT NORMAL') if Time.parse(start_time) > Time.parse(end_time)
  end

  def division
    errors.add(:base, "Minutes must be multiples of #{MIN_LENGTH}") if Time.parse(start_time).min % MIN_LENGTH != 0 || Time.parse(end_time).min % MIN_LENGTH != 0
  end


  def length_interval
    s = Time.parse(start_time)
    e = Time.parse(end_time)
    check = (e.hour * 60 + e.min) - (s.hour * 60 + s.min)
    errors.add(:base, "This interval is outside the available time (#{MAX_LENGTH} minutes)") if check > MAX_LENGTH
    errors.add(:base, "Start time and end time cannot be equal") if check == 0

  end

end
