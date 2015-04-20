json.array!(@slots) do |slot|
  json.extract! slot, :id, :slot1, :slot2, :slot3, :slot4
  json.url slot_url(slot, format: :json)
end
