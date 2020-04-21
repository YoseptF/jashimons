# frozen_string_literal: true

class CreateMascots < ActiveRecord::Migration[6.0]
  def change
    create_table :mascots do |t|
      t.string :name
      t.text :message
      t.float :priceMoney
      t.float :pricePoints

      t.timestamps
    end
  end
end
