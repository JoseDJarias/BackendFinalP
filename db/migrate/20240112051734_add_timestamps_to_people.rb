class AddTimestampsToPeople < ActiveRecord::Migration[7.1]
  def change
    add_timestamps :people, default: Time.zone.now
    change_column_default :people, :created_at, nil
    change_column_default :people, :updated_at, nil  end
end
