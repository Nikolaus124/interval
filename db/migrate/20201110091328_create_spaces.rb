class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.belongs_to :patient, null: false, foreign_key: true
      t.belongs_to :doctor, null: false, foreign_key: true
      t.string :start_time
      t.string :end_time
      t.date :create_date

      t.timestamps
    end
  end
end
