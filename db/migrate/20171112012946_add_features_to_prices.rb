class AddFeaturesToPrices < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :features, :string
  end
end
