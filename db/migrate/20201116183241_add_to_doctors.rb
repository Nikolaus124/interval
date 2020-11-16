class AddToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :begin, :string
    add_column :doctors, :end, :string
  end
end
