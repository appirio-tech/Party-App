class AddSalesforceIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salesforce_id, :integer
    add_index :users, :salesforce_id
  end
end
