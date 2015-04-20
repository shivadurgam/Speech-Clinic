class AddTimeSlotsToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :time_slots, :text
  end
end
