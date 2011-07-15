class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :image
      t.string :facebook_id
      t.string :twitter_id
      t.string :facebook_token
      t.string :twitter_token
      t.string :twitter_secret
      t.string :twitter_name
      t.string :email

      t.boolean :admin
      t.timestamps
    end
  end
end
