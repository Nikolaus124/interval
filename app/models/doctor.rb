class Doctor < ApplicationRecord
  def self.search(dcr)
    where(["doctor_id = ? AND create_date = ?", dcr.to_s])
  end
end
