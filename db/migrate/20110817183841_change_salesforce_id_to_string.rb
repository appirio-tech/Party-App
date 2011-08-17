class ChangeSalesforceIdToString < ActiveRecord::Migration
  def up
    remove_index :users, :salesforce_id
    remove_column :users, :salesforce_id
    add_column :users, :salesforce_id, :string
    add_index :users, :salesforce_id
  end

  def down
    remove_index :users, :salesforce_id
    remove_column :users, :salesforce_id
    add_column :users, :salesforce_id, :string
    add_index :users, :salesforce_id
  end
end
