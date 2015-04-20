class AddUserRefToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :user, index: true
    add_foreign_key :appointments, :users
  end
end
