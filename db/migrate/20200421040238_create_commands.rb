# frozen_string_literal: true

class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.string :name
      t.text :message
      t.string :animation_name
      t.boolean :animation_type
      t.float :duration
      t.float :cooldown
      t.boolean :isEnabled
      t.integer :user_id

      t.timestamps
    end
  end
end
