class AddSlotsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :slots, :text
  end
end
