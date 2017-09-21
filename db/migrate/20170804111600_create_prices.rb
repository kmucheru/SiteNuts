class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.integer :b_amount
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
