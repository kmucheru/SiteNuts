class AddIndepthToPrices < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :indepth, :text
  end
end
