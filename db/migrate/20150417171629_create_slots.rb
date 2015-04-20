class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :slot1
      t.string :slot2
      t.string :slot3
      t.string :slot4

      t.timestamps null: false
    end
  end
end
