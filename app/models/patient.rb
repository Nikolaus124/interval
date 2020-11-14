class Patient < ApplicationRecord
  def name_with_ln
    "#{first_name} #{last_name}"
  end
end

