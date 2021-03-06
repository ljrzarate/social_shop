class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.references :user
      t.string :token
      t.string :secret

      t.timestamps null: false
    end
  end
end
