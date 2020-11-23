class Space < ApplicationRecord
  MIN_LENGTH = 5
  MAX_LENGTH = 30

  validates :start_time, :end_time, length: {is: 5}, :presence => {:message => "must be not null."}

  belongs_to :patient
  belongs_to :doctor
  validate :actual_date, :actual_time, :time_inv, :division, :length_interval, :check_d_h
  validates_with SpaceValidator

  def self.search(search)
    if search
      doctor = Doctor.find_by(position: search)
      if doctor
        where(doctor_id: doctor)
      else
        Space.all
      end
    else
      Space.all
    end
  end

  def actual_date
    errors.add(:base, "incorrect date") if create_date < Time.now.to_date
  end

  def actual_time
    errors.add(:base, "Invalid interval") if Time.parse(start_time) < Time.now && Time.parse(end_time) < Time.now
  end

  def time_inv
    errors.add(:base, "REVERS NOT NORMAL") if Time.parse(start_time) > Time.parse(end_time)
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

  def check_d_h
    d_s = Time.parse(doctor.begin)
    d_e = Time.parse(doctor.end)
    s = Time.parse(start_time)
    e = Time.parse(end_time)
    if (d_s.hour * 60 + d_s.min) > (s.hour * 60 + s.min)
      errors.add(:start_time, "should be not earlier #{doctor.begin}")
    end
    if (d_e.hour * 60 + d_e.min) <= (s.hour * 60 + s.min)
      errors.add(:start_time, "should be earlier #{doctor.end}")
    end
    if (d_e.hour * 60 + d_e.min) <= (e.hour * 60 + e.min)
      errors.add(:base, "Space should be between #{doctor.begin}-#{doctor.end}")
    end
  end
end
