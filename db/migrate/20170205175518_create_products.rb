# frozen_string_literal: true
class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :brand, foreign_key: true
      t.string :model
      t.string :sku
      t.float :price
      t.text :desc

      t.timestamps
    end
  end
end
