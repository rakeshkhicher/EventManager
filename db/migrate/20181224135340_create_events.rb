class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start_date, default: nil
      t.datetime :end_date, default: nil
      t.integer :owner_id

      t.timestamps null: false
    end

    add_index :events, :owner_id
    add_foreign_key :events, :users, column: :owner_id
  end
end
