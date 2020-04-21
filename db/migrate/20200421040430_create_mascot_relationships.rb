# frozen_string_literal: true

class CreateMascotRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :mascot_relationships do |t|
      t.integer :user_id
      t.integer :mascot_id
      t.boolean :isMain

      t.timestamps
    end
  end
end
