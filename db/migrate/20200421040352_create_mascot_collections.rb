# frozen_string_literal: true

class CreateMascotCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :mascot_collections do |t|
      t.integer :user_id
      t.string :default

      t.timestamps
    end
  end
end
