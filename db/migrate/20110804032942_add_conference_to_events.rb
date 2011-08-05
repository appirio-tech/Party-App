class AddConferenceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :conference_id, :integer
    add_index :events, :conference_id
  end
end
