class AddDateRefToSlots < ActiveRecord::Migration
  def change
    add_reference :slots, :date, index: true
    add_foreign_key :slots, :dates
  end
end
