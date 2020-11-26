class Space < ApplicationRecord
  MIN_LENGTH = 5
  MAX_LENGTH = 30

  validates :create_date, presence: true
  validates :start_time, :end_time, presence: true

  belongs_to :patient
  belongs_to :doctor
  validate :actual_date, :actual_time, :check_d_h
  validates_with SpaceValidator

  def actual_date
    unless create_date.nil?
      errors.add(:base, "Incorrect date") if create_date < Time.now.to_date
    end
  end

  def actual_time
    if start_time.length != 0
      if end_time.length != 0
        errors.add(:base, "Invalid interval") if Time.parse(start_time) < Time.now && Time.parse(end_time) < Time.now
        errors.add(:base, "Minutes must be multiples of #{MIN_LENGTH}") if Time.parse(start_time).min % MIN_LENGTH != 0 || Time.parse(end_time).min % MIN_LENGTH != 0

        s = Time.parse(start_time)
        e = Time.parse(end_time)
        check = (e.hour * 60 + e.min) - (s.hour * 60 + s.min)
        errors.add(:base, "This interval is outside the available time (#{MAX_LENGTH} minutes)") if check > MAX_LENGTH
        errors.add(:base, "Start time and end time cannot be equal") if check == 0
      end
    end
  end

  def check_d_h
    unless doctor.nil?
      if start_time.length != 0
        if end_time.length != 0
          d_s = Time.parse(doctor.begin)
          d_e = Time.parse(doctor.end)
          s = Time.parse(start_time)
          e = Time.parse(end_time)
          if (d_s.hour * 60 + d_s.min) > (s.hour * 60 + s.min)
            errors.add(:start_time, "should be not earlier #{doctor.begin}")
          end
          if (d_e.hour * 60 + d_e.min) < (s.hour * 60 + s.min)
            errors.add(:start_time, "should be earlier #{doctor.end}")
          end
          if (d_e.hour * 60 + d_e.min) < (e.hour * 60 + e.min)
            errors.add(:base, "Space should be between #{doctor.begin}-#{doctor.end}")
          end
        end
      end
    end
  end

  def self.search(dcr, dt)
    where(["doctor_id = ? AND create_date = ?", dcr.to_s, dt.to_s])
  end

end
