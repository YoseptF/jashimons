# frozen_string_literal: true

class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.string :name
      t.text :message
      t.string :animationName
      t.boolean :animationType
      t.float :duration
      t.float :cooldown
      t.boolean :isEnabled
      t.integer :user_id

      t.timestamps
    end
  end
end
