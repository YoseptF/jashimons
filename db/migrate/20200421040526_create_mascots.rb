# frozen_string_literal: true

class CreateMascots < ActiveRecord::Migration[6.0]
  def change
    create_table :mascots do |t|
      t.string :name
      t.text :message

      t.timestamps
    end
  end
end
