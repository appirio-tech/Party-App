class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :organizer
      t.string :name
      t.string :location_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.boolean :approved
      t.datetime :start_time
      t.datetime :end_time
      t.text :description

      t.timestamps
    end
    add_index :events, :organizer_id
  end
end
