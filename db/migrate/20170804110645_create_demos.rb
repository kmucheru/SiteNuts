class CreateDemos < ActiveRecord::Migration[5.1]
  def change
    create_table :demos do |t|
      t.binary :d_pic
      t.binary :m_pic
      t.binary :t_pic
      t.binary :r1_pic
      t.binary :r2_pic
      t.string :name
      t.string :b_amount
      t.text :description

      t.timestamps
    end
  end
end
