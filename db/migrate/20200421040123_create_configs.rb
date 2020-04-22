# frozen_string_literal: true

class CreateConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.boolean :direction
      t.boolean :show
      t.string :black_list
      t.string :bubble
      t.integer :user_id

      t.timestamps
    end
  end
end
