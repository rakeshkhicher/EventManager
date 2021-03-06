class CreateEventUsers < ActiveRecord::Migration
  def change
    create_table :event_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.datetime :accepted_at
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
