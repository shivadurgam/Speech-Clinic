class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
