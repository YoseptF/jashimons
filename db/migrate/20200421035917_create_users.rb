# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :twitch_token
      t.string :twitch_refresh

      t.timestamps
    end
  end
end
