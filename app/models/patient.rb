class Patient < ApplicationRecord
  validates :first_name, :presence => {:message => "must be not null."}
  validates :last_name, :presence => {:message => "must be not null."}

  #validate :validates_each

  validates_each :first_name, :last_name do |record, attr, value|
    record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
  end

  def name_with_ln
    "#{first_name} #{last_name}"
  end
end

